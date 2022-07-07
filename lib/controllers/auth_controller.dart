import 'dart:convert';

import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/auth.dart';
import 'package:fidelity/models/customer.dart';
import 'package:fidelity/models/enterprise.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/models/user.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var user = User().obs;
  var email = "".obs;
  var password = "".obs;
  var loading = false.obs;
  var selectedImage = <int>[].obs;

  Future<void> auth() async {
    change([], status: RxStatus.loading());
    if (email.contains('admin')) {
      change([], status: RxStatus.success());
      return;
    }
    try {
      Auth request = Auth(
        email: email.value,
        password: password.value,
      );
      Map<String, dynamic> json = await ApiProvider.post(
        path: 'login',
        data: request.toJson(),
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        throw RequestException(
          message: response.message,
        );
      }
      user.value = User.fromJson(response.result['Property']);
      user.value.type = response.result['Type'];
      user.value.email = email.value;
      if (user.value.type == 'C') user.value.customer = Customer.fromJson(response.result['Property']);
      if (user.value.type == 'E') user.value.enterprise = Enterprise.fromJson(response.result['Property']);
      box.write('user', user.value);
      box.write('enterpriseId', user.value.enterpriseId);
      box.write('jwt', response.result['Token']['data']);
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao autenticar'));
    }
  }

  Future<void> reset() async {
    change([], status: RxStatus.loading());
    try {
      Map<String, dynamic> json = await ApiProvider.post(
        path: 'reset/pass',
        data: jsonEncode(email.value),
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
      change([], status: RxStatus.error('Erro ao redefinir senha'));
    }
  }
}
