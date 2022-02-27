import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/product.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var product = Product().obs;
  var loading = false.obs;

  //List Product
  var currentListProducts = ProductEntries().obs;

  //Add Product
  var currentAddProduct = Product().obs;

  setCurrentAddProduct({String? name, double? value, int? categoryId, String? image, bool? active}) {
    currentAddProduct.value.name = name;
    currentAddProduct.value.value = value;
    currentAddProduct.value.categoryId = categoryId;
    currentAddProduct.value.image = image;
    currentAddProduct.value.active = currentAddProduct.value.active == null ? null : currentAddProduct.value.active = active;
  }

  Future<void> getList() async {
    change([], status: RxStatus.loading());
    try {
      Map<String, dynamic> json = await ApiProvider.get(
        path: 'products',
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        throw RequestException(
          message: response.message,
        );
      }
      currentListProducts.value = new ProductEntries(
        products: response.result.map((e) => Product.fromJson(e)).toList()
      );
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao autenticar'));
    }
  }

  Future<void> saveProduct() async {
    change([], status: RxStatus.loading());
    try {
      Map<String, dynamic> json = await ApiProvider.post(
        path: 'new/product',
        data: product.toJson(),
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
