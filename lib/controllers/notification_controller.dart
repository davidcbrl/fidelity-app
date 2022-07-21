import 'package:fidelity/models/one_signal_push.dart';
import 'package:fidelity/models/one_signal_response.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/one_signal_provider.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController with StateMixin {
  var push = OneSignalPush().obs;

  Future<void> sendPush() async {
    try {
      push.value.appId = 'f5fb5ded-0185-4984-8024-53f233218894';
      Map<String, dynamic> json = await OneSignalProvider.post(
        path: 'notifications',
        data: push.toJson(),
      );
      OneSignalResponse response = OneSignalResponse.fromJson(json);
      if (response.errors != null) {
        throw RequestException(
          message: response.errors.toString(),
        );
      }
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro notificar cliente'));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro notificar cliente'));
    }
  }
}
