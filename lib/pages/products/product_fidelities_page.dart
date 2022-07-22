import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/models/fidelity.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_link_item.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFidelitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Deseja vincular uma fidelidade?',
      ),
      body: ProductFidelitiesBody(),
    );
  }
}

class ProductFidelitiesBody extends StatefulWidget {
  @override
  _ProductFidelitiesBodyState createState() => _ProductFidelitiesBodyState();
}

class _ProductFidelitiesBodyState extends State<ProductFidelitiesBody> {
  ProductController productController = Get.find();
  FidelityController fidelityController = Get.put(FidelityController());
  List<Fidelity?> _selectedFidelities = [];

  @override
  void initState() {
    if (productController.product.value.fidelities != null) {
      _selectedFidelities = productController.product.value.fidelities!.map((e) => Fidelity.fromJson(e)).toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => productController.loading.value
          ? FidelityLoading(
              loading: productController.loading.value,
              text: 'Salvando produto...',
            )
          : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Selecione as fidelidades que desejar vincular à este produto ou crie uma nova fidelidade',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FidelityButton(
                  label: 'Nova fidelidade',
                  onPressed: () {
                    fidelityController.fidelity.value = Fidelity();
                    Get.toNamed("/fidelity/add");
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                _fidelitiesList(),
                SizedBox(
                  height: 20,
                ),
                FidelityButton(
                  label: 'Concluir',
                  onPressed: () {
                    saveProduct(context);
                  },
                ),
                FidelityTextButton(
                  label: 'Voltar',
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
    );
  }

  Widget _fidelitiesList() {
    return Expanded(
      child: Obx(
        () => fidelityController.loading.value
            ? FidelityLoading(
                loading: fidelityController.loading.value,
                text: 'Carregando fidelidades...',
              )
            : SingleChildScrollView(
                child: Column(children: [
                  if (fidelityController.status.isSuccess) ...[
                    ...fidelityController.fidelitiesList.map(
                      (Fidelity fidelity) {
                        fidelity.products = null;
                        return FidelityLinkItem(
                          id: fidelity.id ?? 1,
                          label: fidelity.name ?? '',
                          description: fidelity.description ?? '',
                          selected: containsFidelityId(fidelity.id),
                          active: fidelity.status ?? true,
                          onPressed: () {
                            if (containsFidelityId(fidelity.id)) {
                              setState(() {
                                _selectedFidelities.removeWhere((element) => element!.id == fidelity.id);
                              });
                              return;
                            }
                            setState(() {
                              _selectedFidelities.add(fidelity);
                            });
                          },
                        );
                      },
                    ),
                  ],
                  if (fidelityController.status.isEmpty) ...[
                    FidelityEmpty(
                      text: 'Nenhuma fidelidade encontrada',
                    ),
                  ],
                  if (fidelityController.status.isError) ...[
                    FidelityEmpty(
                      text: fidelityController.status.errorMessage ?? '500',
                    ),
                  ],
                ]),
              ),
      ),
    );
  }

  bool containsFidelityId(int? id) {
    for (Fidelity? e in _selectedFidelities) {
      if (e?.id == id) return true;
    }
    return false;
  }

  Future<void> saveProduct(BuildContext context) async {
    productController.loading.value = true;
    productController.product.value.fidelitiesIds = _selectedFidelities.map((e) => e!.id).toList();
    await productController.saveProduct();
    if (productController.status.isSuccess) {
      productController.loading.value = false;
      Get.toNamed('/product/success');
      return;
    }
    productController.loading.value = false;
    _showErrorDialog(context);
  }

  Future<dynamic> _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Produtos',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          productController.status.errorMessage ?? 'Erro ao salvar produto',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FidelityButton(
              label: 'OK',
              width: double.maxFinite,
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
