import 'package:get/get.dart';

import '../models/api_response.dart';
import '../models/product.dart';
import '../models/request_exception.dart';
import '../providers/api_provider.dart';

class ProductController extends GetxController with StateMixin {
  var currentProduct = Product().obs;
  var currentListProducts = ProductEntries().obs;

  Future<void> getList() async {
    change([], status: RxStatus.loading());
    try {
      Product request = Product();
      Map<String, dynamic> json = await ApiProvider.post(
        path: 'list_product',
        data: request.toJson(),
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
