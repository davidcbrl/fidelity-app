import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/models/user.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EmployeeController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var enterpriseId = 0.obs;
  var loading = false.obs;
  var filter = ''.obs;
  var filterDelay = false.obs;
  var page = 1.obs;
  var pageSize = 10.obs;
  var employee = User().obs;
  var employeesList = <User>[].obs;
  var selectedImage = <int>[].obs;

  @override
  void onInit() {
    enterpriseId.value = box.read('enterpriseId');
    getEmployees();

    ever(filter, (_) async {
      if (filter.value.length == 0) {
        getEmployees();
        return;
      }
      if (filter.value.length < 3 || filterDelay.value) {
        return;
      }
      filterDelay.value = true;
      await Future.delayed(Duration(seconds: 1));
      filterDelay.value = false;
      page.value = 1;
      employeesList.clear();
      getEmployees();
    });

    super.onInit();
  }

  Future<void> getEmployees() async {
    change([], status: RxStatus.loading());
    loading.value = true;
    try {
      String path = 'employees?page=${page.value}&pagesize=${pageSize.value}';
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
        employeesList.value = list.map((e) => User.fromJson(e)).toList();
      }
      if (page.value > 1 && list.length > 0) {
        employeesList.addAll(list.map((e) => User.fromJson(e)).toList());
      }
      change([], status: RxStatus.success());
      loading.value = false;
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
      loading.value = false;
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao buscar funcionários'));
      loading.value = false;
    }
  }

  void getEmployeesNextPage() {
    page.value = page.value + 1;
    getEmployees();
  }

  Future<void> saveEmployee() async {
    change([], status: RxStatus.loading());
    try {
      employee.value.employee!.enterpriseId = box.read('enterpriseId');
      Map<String, dynamic> json;
      json = employee.value.employee!.id != null
        ? await ApiProvider.put(path: 'employees', data: employee.toJson())
        : await ApiProvider.post(path: 'employees', data: employee.toJson());
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        throw RequestException(
          message: response.message,
        );
      }
      getEmployees();
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao salvar funcionário'));
    }
  }
}
