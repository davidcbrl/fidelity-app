import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/enterprise.dart';
import 'package:fidelity/models/plan.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/models/user.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EnterpriseController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var loading = false.obs;
  var userSignup = User().obs;
  var signupEnterprise = Enterprise().obs;
  var plan = Plan().obs;
  var plansList = <Plan>[].obs;
  var plansLoading = false.obs;

  @override
  void onInit() {
    getPlans();
    super.onInit();
  }

  Future<void> signup() async {
    User user = userSignup.value;
    try {
      Map<String, dynamic> json = await ApiProvider.post(
        path: 'enterprises',
        data: user.toJson(),
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        throw RequestException(
          message: response.message,
        );
      }
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao autenticar'));
    }
  }

  Future<void> getPlans() async {
    change([], status: RxStatus.loading());
    plansLoading.value = true;
    try {
      Map<String, dynamic> json = await ApiProvider.get(
        path: 'memberships',
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        plansLoading.value = false;
        throw RequestException(
          message: response.message,
        );
      }
      if (response.result.length == 0 || response.result == null) {
        change([], status: RxStatus.empty());
        plansLoading.value = false;
        return;
      }
      List<dynamic> list = response.result;
      plansList.value = list.map((e) => Plan.fromJson(e)).toList();
      change([], status: RxStatus.success());
      plansLoading.value = false;
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
      plansLoading.value = false;
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao buscar planos'));
      plansLoading.value = false;
    }
  }
}
