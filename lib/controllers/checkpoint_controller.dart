import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/checkpoint.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CheckpointController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var loading = false.obs;
  var checkpoints = <Checkpoint>[].obs;

  Future<void> saveCheckpoint() async {
    change([], status: RxStatus.loading());
    try {
      Map<String, dynamic> json;
      await Future.forEach(this.checkpoints, (Checkpoint check) async {
        json = await ApiProvider.post(
          path: 'checkpoints',
          data: check.toJson(),
        );
        ApiResponse response = ApiResponse.fromJson(json);
        if (!response.success) {
          throw RequestException(
            message: response.message,
          );
        }
        if (response.result['Status']) {
          check.completed = true;
        }
      });
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao realizar checkpoint'));
    }
  }
}
