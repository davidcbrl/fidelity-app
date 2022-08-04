import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/models/api_response.dart';
import 'package:fidelity/models/fidelity.dart';
import 'package:fidelity/models/fidelity_type.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FidelityController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  AuthController authController = Get.find();
  var enterpriseId = 0.obs;
  var loading = false.obs;
  var fidelity = Fidelity().obs;
  var filter = ''.obs;
  var filterDelay = false.obs;
  var pageSize = 10.obs;
  var fidelitiesList = <Fidelity>[].obs;
  var isInvalid = false.obs;
  var page = 1.obs;
  var fidelitySelectedAdd = Fidelity().obs;

  @override
  void onInit() {
    enterpriseId.value = box.read('enterpriseId');
    filter.value = '';
    getFidelities();
    ever(filter, (_) async {
      if (filter.value.length == 0) {
        getFidelities();
        return;
      }
      if (filter.value.length < 3 || filterDelay.value) {
        return;
      }
      filterDelay.value = true;
      await Future.delayed(Duration(seconds: 1));
      filterDelay.value = false;
      page.value = 1;
      fidelitiesList.clear();
      await getFidelities();
    });
    super.onInit();
  }

  Future<void> saveFidelity() async {
    change([], status: RxStatus.loading());
    try {
      fidelity.value.enterpriseId = enterpriseId.value;
      Map<String, dynamic> json = fidelity.value.id == null
          ? await ApiProvider.post(
              path: 'loyalts',
              data: fidelity.toJson(),
            )
          : await ApiProvider.put(
              path: 'loyalts',
              data: fidelity.toJson(),
            );
      ApiResponse response = ApiResponse.fromJson(json);
      if (!response.success) {
        throw RequestException(
          message: response.message,
        );
      }
      getFidelities();
      change([], status: RxStatus.success());
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro salvar fidelidade'));
    }
  }

  Future<void> getFidelities() async {
    change([], status: RxStatus.loading());
    loading.value = true;
    try {
      String path = 'loyalts?page=${page.value}&pagesize=${pageSize.value}';
      if (filter.value.length >= 3) {
        path = '$path&name=${filter.value}';
      }
      if (authController.user.value.type == 'C') {
        path = '$path&company=${enterpriseId.value}';
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
        fidelitiesList.value = list.map((e) => Fidelity.fromJson(e)).toList();
      }
      if (page.value > 1 && list.length > 0) {
        fidelitiesList.value.addAll(list.map((e) => Fidelity.fromJson(e)).toList());
      }
      change([], status: RxStatus.success());
      loading.value = false;
    } on RequestException catch (error) {
      print(error);
      change([], status: RxStatus.error(error.message));
      loading.value = false;
    } catch (error) {
      print(error);
      change([], status: RxStatus.error('Erro buscar fidelidades'));
      loading.value = false;
    }
  }

  void getFidelitiesNextPage() {
    if (filter.isEmpty) {
      page.value = page.value + 1;
      getFidelities();
    }
  }

  fakeFidelityTypeList() {
    FidelityType type1 = new FidelityType();
    type1.name = "Quantidade";
    type1.description =
        "Na compra de um determinado número de produtos, o cliente alcança a promoção. Exemplo:“Na compra de 10 viagens, ganhe um dia de SPA”";
    type1.id = 1;
    FidelityType type2 = new FidelityType();
    type2.name = "Pontuacao";
    type2.description =
        'A cada compra o cliente adquire pontos, ao acumular um determinado número de pontos, o cliente alcança a promoção. Exemplo:“Acumule 200 pontos e ganhe um dia de SPA”';
    type2.id = 2;

    FidelityType type3 = new FidelityType();
    type3.name = "Valor";
    type3.description =
        'Ao efetuar uma compra de um determinado valor, o cliente alcança a promoção. Exemplo:“Compras acima de R\$500, ganham um dia de SPA”';
    type3.id = 3;
    return [type1, type2, type3];
  }
}
