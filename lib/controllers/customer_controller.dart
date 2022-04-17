import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/customer_progress.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/models/user.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomerController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var loading = false.obs;
  var customerCPF = ''.obs;
  var customerProgress = <CustomerProgress>[].obs;

  Future<void> signup(User user) async {
    try {
      Map<String, dynamic> json = await ApiProvider.post(
        path: 'clients',
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

  Future<void> getCustomerProgress() async {
    change([], status: RxStatus.loading());
    loading.value = true;
    try {
      String path = 'checkpoints?cpf=${customerCPF.value}';
      Map<String, dynamic> json = await ApiProvider.get(
        path: path,
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        loading.value = false;
        throw RequestException(
          message: response.message,
        );
      }
      if (response.result.length == 0 || response.result == null) {
        change([], status: RxStatus.empty());
        loading.value = false;
        return;
      }
      List<dynamic> list = response.result;
      customerProgress.value = list.map((e) => CustomerProgress.fromJson(e)).toList();
      change([], status: RxStatus.success());
      loading.value = false;
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
      loading.value = false;
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao buscar progresso do cliente'));
      loading.value = false;
    }
  }
}
