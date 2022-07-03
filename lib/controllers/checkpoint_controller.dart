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
      Checkpoints checks = Checkpoints(checkpoints: checkpoints);
      Map<String, dynamic> json = await ApiProvider.post(
        path: 'checkpoints',
        data: checks.toJson(),
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        throw RequestException(
          message: response.message,
        );
      }
      List<dynamic> list = response.result;
      checkpoints.value = list.map((e) => Checkpoint.fromJson(e)).toList();
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
