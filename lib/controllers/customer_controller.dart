import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/models/user.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';

import '../models/customer.dart';

class CustomerController extends GetxController with StateMixin {
  var currentAddCustomer = Customer().obs;
  var loading = false.obs;

  setCurrentAddCustomer(Customer customer) {
    currentAddCustomer.value = customer;
  }

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
}
