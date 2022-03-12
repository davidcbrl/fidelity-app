import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/product.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var loading = false.obs;
  var product = Product().obs;
  var productsList = <Product>[].obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  //Add Product
  var currentAddProduct = Product().obs;

  setCurrentAddProduct({String? name, double? value, int? categoryId, String? image, bool? active}) {
    currentAddProduct.value.name = name;
    currentAddProduct.value.value = value;
    currentAddProduct.value.categoryId = categoryId;
    currentAddProduct.value.image = image;
    currentAddProduct.value.active = currentAddProduct.value.active == null ? null : currentAddProduct.value.active = active;
  }

  Future<void> getProducts() async {
    change([], status: RxStatus.loading());
    loading.value = true;
    try {
      Map<String, dynamic> json = await ApiProvider.get(
        path: 'products',
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        loading.value = false;
        throw RequestException(
          message: response.message,
        );
      }
      if (response.result.length == 0 || response.result == null) {
        change([], status: RxStatus.empty());
        loading.value = false;
        return;
      }
      List<dynamic> list = response.result;
      productsList.value = list.map((e) => Product.fromJson(e)).toList();
      change([], status: RxStatus.success());
      loading.value = false;
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
      loading.value = false;
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao autenticar'));
      loading.value = false;
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
