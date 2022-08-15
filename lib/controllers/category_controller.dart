import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/category.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoryController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var enterpriseId = 0.obs;
  var loading = false.obs;
  var filter = ''.obs;
  var filterDelay = false.obs;
  var page = 1.obs;
  var pageSize = 10.obs;
  var category = Category().obs;
  var categoriesList = <Category>[].obs;

  @override
  void onInit() {
    enterpriseId.value = box.read('enterpriseId');
    getCategories();

    ever(filter, (_) async {
      if (filter.value.length == 0) {
        getCategories();
        return;
      }
      if (filter.value.length < 3 || filterDelay.value) {
        return;
      }
      filterDelay.value = true;
      await Future.delayed(Duration(seconds: 1));
      filterDelay.value = false;
      page.value = 1;
      categoriesList.clear();
      getCategories();
    });

    super.onInit();
  }

  Future<void> getCategories() async {
    change([], status: RxStatus.loading());
    loading.value = true;
    try {
      Map<String, dynamic> json = await ApiProvider.get(
        path: 'categories',
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
      categoriesList.value = list.map((e) => Category.fromJson(e)).toList();
      change([], status: RxStatus.success());
      loading.value = false;
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
      loading.value = false;
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao buscar categorias'));
      loading.value = false;
    }
  }

  void getCategoriesNextPage() {
    page.value = page.value + 1;
    getCategories();
  }

  Future<void> saveCategory() async {
    change([], status: RxStatus.loading());
    try {
      category.value.enterpriseId = box.read('enterpriseId');
      Map<String, dynamic> json;
      json = category.value.id != null
        ? await ApiProvider.put(path: 'categories', data: category.toJson())
        : await ApiProvider.post(path: 'categories', data: category.toJson());
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        throw RequestException(
          message: response.message,
        );
      }
      getCategories();
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao salvar categoria'));
    }
  }
}
