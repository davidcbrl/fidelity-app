import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/checkpoint.dart';
import 'package:fidelity/models/customer.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/models/user.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomerController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var loading = false.obs;
  var customer = Customer().obs;
  var customerCPF = ''.obs;
  var customerProgress = <Checkpoint>[].obs;

  Future<void> saveCustomer(User user) async {
    change([], status: RxStatus.loading());
    try {
      Map<String, dynamic> json = user.id != null
          ? await ApiProvider.put(path: 'clients', data: user.toJson())
          : await ApiProvider.post(path: 'clients', data: user.toJson());
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        throw RequestException(
          message: response.message,
        );
      }
      if (user.id != null) {
        box.write('user', user);
      }
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao salvar cliente'));
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
      if (response.count > 0) {
        List<dynamic> list = response.result['LoyaltProgress'];
        customerProgress.value = list.map((e) => Checkpoint.fromJson(e)).toList();
      }
      customer.value = Customer.fromJson(response.result['Client']);
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
