import 'package:get/get.dart';

import '../models/api_response.dart';
import '../models/enterprise.dart';
import '../models/request_exception.dart';
import '../models/user.dart';
import '../providers/api_provider.dart';

class EnterpriseController extends GetxController with StateMixin {
  var signupEnterprise = Enterprise().obs;
  var userSignup = User().obs;
  var loading = false.obs;

  Future<void> signup() async {
    User user = userSignup.value;
    try {
      Map<String, dynamic> json = await ApiProvider.post(
        path: 'new/enterprise',
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
