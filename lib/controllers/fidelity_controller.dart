import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/fidelity.dart';
import 'package:fidelity/models/fidelity_type.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FidelityController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var loading = false.obs;
  var fidelity = Fidelity().obs;
  var fidelitiesList = <Fidelity>[].obs;

  @override
  void onInit() {
    getFidelities();
    super.onInit();
  }

  Future<void> getFidelities() async {
    loading.value = true;
    change([], status: RxStatus.loading());
    try {
      Map<String, dynamic> json = await ApiProvider.get(
        path: 'loyalts',
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
      fidelitiesList.value = list.map((e) => Fidelity.fromJson(e)).toList();
      change([], status: RxStatus.success());
      loading.value = false;
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao autenticar'));
    }
  }

  fakeFidelityTypeList() {
    return List.generate(3, (index) {
      FidelityType type = new FidelityType();
      type.name = "nome" + index.toString();
      type.description = "descricao" + index.toString();
      type.id = index;
      return type;
    });
  }
}
