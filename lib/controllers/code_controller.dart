import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CodeController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var loading = false.obs;
}
