import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';

import '../models/api_response.dart';
import '../models/product.dart';
import '../models/request_exception.dart';

class ProductApiProvider extends ApiProvider {
  ProductController controller = Get.find<ProductController>();

  Future<void> getList() async {
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
    } on RequestException catch (error) {
      print(error);
    } catch (error) {
      print(error);
    }
  }
}
