import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/enterprise.dart';
import 'package:fidelity/models/enterprise_dashboard.dart';
import 'package:fidelity/models/plan.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/models/user.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EnterpriseController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  var loading = false.obs;
  var filter = ''.obs;
  var filterDelay = false.obs;
  var page = 1.obs;
  var pageSize = 10.obs;
  var enterprisesList = <Enterprise>[].obs;
  var userSignup = User().obs;
  var signupEnterprise = Enterprise().obs;
  var dashboard = EnterpriseDashboard().obs;
  var profileEnterprise = User().obs;
  var selectedImage = <int>[].obs;

  var plan = Plan().obs;
  var plansList = <Plan>[].obs;
  var plansLoading = false.obs;
  @override
  void onInit() {
    ever(filter, (_) async {
      if (filter.value.length == 0) {
        getEnterprises();
        return;
      }
      if (filter.value.length < 3 || filterDelay.value) {
        return;
      }
      filterDelay.value = true;
      await Future.delayed(Duration(seconds: 1));
      filterDelay.value = false;
      page.value = 1;
      enterprisesList.clear();
      await getEnterprises();
    });
    getMostUsedLoyalts();
    getPlans();
    super.onInit();
  }

  Future<void> changeProfile() async {
    try {
      loading.value = true;

      Map<String, dynamic> json = await ApiProvider.put(
        path: 'enterprises',
        data: profileEnterprise.toJson(),
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        loading.value = false;
        throw RequestException(
          message: response.message,
        );
      }
      loading.value = false;
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao alterar dados de perfil'));
    }
  }

  Future<void> signup() async {
    User user = userSignup.value;
    try {
      Map<String, dynamic> json = await ApiProvider.post(
        path: 'enterprises',
        data: user.toJson(),
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

  Future<void> getPlans() async {
    change([], status: RxStatus.loading());
    plansLoading.value = true;
    try {
      Map<String, dynamic> json = await ApiProvider.get(
        path: 'memberships',
      );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        plansLoading.value = false;
        throw RequestException(
          message: response.message,
        );
      }
      if (response.result.length == 0 || response.result == null) {
        change([], status: RxStatus.empty());
        plansLoading.value = false;
        return;
      }
      List<dynamic> list = response.result;
      plansList.value = list.map((e) => Plan.fromJson(e)).toList();
      change([], status: RxStatus.success());
      plansLoading.value = false;
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
      plansLoading.value = false;
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao buscar planos'));
      plansLoading.value = false;
    }
  }

  Future<void> getMostUsedLoyalts() async {
    change([], status: RxStatus.loading());
    try {
      loading.value = true;
      Map<String, dynamic> json = await ApiProvider.get(
        path: 'dashboard',
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
      var x = response.result;
      dashboard.value = EnterpriseDashboard.fromJson(x);
      dashboard.value.mostUsedLoyalts?.forEach((e) {
        dashboard.value.convertedList?.addAll({e['Name']: double.parse(e['Number'].toString())});
      });
      loading.value = false;
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
      plansLoading.value = false;
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao buscar planos'));
      plansLoading.value = false;
    }
  }

  Future<void> getEnterprises() async {
    change([], status: RxStatus.loading());
    loading.value = true;
    try {
      String path = 'enterprises?page=${page.value}&pagesize=${pageSize.value}';
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
        enterprisesList.value = list.map((e) {
          Enterprise enterprise = Enterprise.fromJson(e['Enterprise']);
          enterprise.image = e['Image'];
          return enterprise;
        }).toList();
      }
      if (page.value > 1 && list.length > 0) {
        enterprisesList.value.addAll(list.map((e) {
          Enterprise enterprise = Enterprise.fromJson(e['Enterprise']);
          enterprise.image = e['Image'];
          return enterprise;
        }).toList());
      }
      change([], status: RxStatus.success());
      loading.value = false;
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
      loading.value = false;
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro ao buscar empresas'));
      loading.value = false;
    }
  }

  void getEnterprisesNextPage() {
    if (filter.isEmpty) {
      page.value = page.value + 1;
      getEnterprises();
    }
  }
}
