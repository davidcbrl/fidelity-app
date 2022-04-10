import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/product_category.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductCategoryController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var companyId = 0.obs;
  var loading = false.obs;
  var category = ProductCategory().obs;
  var categoriesList = <ProductCategory>[].obs;

  @override
  void onInit() {
    companyId.value = box.read('companyId');
    getCategories();
    super.onInit();
  }

  Future<void> getCategories() async {
    change([], status: RxStatus.loading());
    loading.value = true;
    try {
      Map<String, dynamic> json = await ApiProvider.get(
        path: 'categories?company=${companyId.value}',
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
      categoriesList.value = list.map((e) => ProductCategory.fromJson(e)).toList();
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
}
