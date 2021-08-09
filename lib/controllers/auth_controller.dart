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

  Future<void> auth() async {
    change([], status: RxStatus.loading());
    try {
      AuthRequest request = AuthRequest((b) => b
        ..email = email.value
        ..password = password.value
        ..type = 'C'
      );
      ApiResponse response = await ApiProvider.post(
        path: 'login',
        data: request.toJson(),
        fromJson: ApiResponse.fromJson,
      );
      if (!response.success) {
        throw RequestException(
          message: response.message,
        );
      }
      user = User((b) => b
        ..id = (response.result as dynamic).Property.Id
        ..name = (response.result as dynamic).Property.Name
      );
      box.write('jwt', (response.result as dynamic).Token.data);
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
