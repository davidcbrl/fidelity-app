import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/fidelity.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FidelityController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var loading = false.obs;
  var fidelities = Fidelity().obs;
  var fidelitiesList = <Fidelity>[].obs;

  @override
  void onInit() {
    getFidelities();
    super.onInit();
  }

  Future<void> getFidelities() async {
    change([], status: RxStatus.loading());
    try {
      Map<String, dynamic> json = await ApiProvider.get(
        path: 'loyalts',
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        throw RequestException(
          message: response.message,
        );
      }
      if (response.result.length == 0 || response.result == null) {
        change([], status: RxStatus.empty());
        return;
      }
      List<dynamic> list = response.result;
      fidelitiesList.value = list.map((e) => Fidelity.fromJson(e)).toList();
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao autenticar'));
    }
  }
}
