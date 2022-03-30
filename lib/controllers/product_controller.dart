import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/product.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var loading = false.obs;
  var filter = ''.obs;
  var page = 1.obs;
  var pageSize = 10.obs;
  var product = Product().obs;
  var productsList = <Product>[].obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  Future<void> getProducts() async {
    change([], status: RxStatus.loading());
    loading.value = true;
    try {
      String path = 'products?page=${page.value}&pagesize=${pageSize.value}';
      if (filter.value.length >= 3) {
        path = '$path&name=${filter.value}';
      }
      Map<String, dynamic> json = await ApiProvider.get(
        path: path,
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        loading.value = false;
        throw RequestException(
          message: response.message,
        );
      }
      if ((response.result.length == 0 || response.result == null) && page.value == 1) {
        change([], status: RxStatus.empty());
        loading.value = false;
        return;
      }
      List<dynamic> list = response.result;
      if (page.value == 1) {
        productsList.value = list.map((e) => Product.fromJson(e)).toList();
      }
      if (page.value > 1 && list.length > 0) {
        productsList.value.addAll(list.map((e) => Product.fromJson(e)).toList());
      }
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

  void getProductsNextPage() {
    page.value = page.value + 1;
    getProducts();
  }

  Future<void> saveProduct() async {
    change([], status: RxStatus.loading());
    try {
      product.value.companyId = box.read('companyId');
      Map<String, dynamic> json = await ApiProvider.post(
        path: 'products',
        data: product.toJson(),
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        throw RequestException(
          message: response.message,
        );
      }
      getProducts();
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
