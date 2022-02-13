import 'package:fidelity/models/product_category.dart';
import 'package:get/get.dart';

import '../models/api_response.dart';
import '../models/product.dart';
import '../models/request_exception.dart';
import '../providers/api_provider.dart';

class ProductController extends GetxController with StateMixin {
  var currentProduct = Product().obs;

  //List Product
  var currentListProducts = ProductEntries().obs;

  //Add Product
  var currentAddProduct = Product().obs;

  setCurrentAddProduct({String? name, String? value, ProductCategory? category, String? photo, bool? active}) {
    currentAddProduct.value.name = name;
    currentAddProduct.value.value = value;
    currentAddProduct.value.category = category;
    currentAddProduct.value.photo = photo;
    currentAddProduct.value.active == null ? null : currentAddProduct.value.active = active;
  }

  //ApiProvider
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
