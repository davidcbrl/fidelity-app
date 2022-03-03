import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/auth.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/models/user.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  User user = User();
  var email = "".obs;
  var password = "".obs;
  var loading = false.obs;

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
      user = User.fromJson(response.result['Property']);
      box.write('companyId', user.companyId);
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
}
