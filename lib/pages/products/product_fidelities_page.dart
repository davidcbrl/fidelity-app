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
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

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
  late ScrollController scrollController;

  @override
  void initState() {
    if (productController.product.value.fidelities != null) {
      _selectedFidelities = productController.product.value.fidelities!.map((e) => Fidelity.fromJson(e)).toList();
    }
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
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
                style: Theme.of(context).textTheme.labelMedium,
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
        () => LazyLoadScrollView(
          isLoading: fidelityController.loading.value,
          scrollOffset: 10,
          onEndOfPage: () => fidelityController.getFidelitiesNextPage(),
          child: Container(
            child: RefreshIndicator(
              onRefresh: () => _refresh(),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  if (!fidelityController.status.isError && fidelityController.fidelitiesList.length > 0) ...[
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
                  if (fidelityController.status.isLoading) ...[
                    FidelityLoading(
                      loading: fidelityController.loading.value,
                      text: 'Carregando fidelidades...',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    fidelityController.page.value = 1;
    await fidelityController.getFidelities();
  }

  dynamic _scrollListener() {
    FocusScope.of(context).requestFocus(new FocusNode());
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
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          productController.status.errorMessage ?? 'Erro ao salvar produto',
          style: Theme.of(context).textTheme.labelMedium,
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
