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
  List<Fidelity> _selectedFidelities = [];

  @override
  void initState() {
    listFidelities();
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
                print('CLICOU');
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
            child: Column(
              children: [
                if (fidelityController.status.isSuccess)... [
                  ...fidelityController.fidelitiesList.map(
                    (Fidelity fidelity) => FidelityLinkItem(
                      id: fidelity.id ?? 1,
                      label: fidelity.name ?? '',
                      description: fidelity.description ?? '',
                      selected: _selectedFidelities.contains(fidelity),
                      onPressed: () {
                        if (_selectedFidelities.contains(fidelity)) {
                          setState(() {
                            _selectedFidelities.remove(fidelity);
                          });
                          return;
                        }
                        setState(() {
                          _selectedFidelities.add(fidelity);
                        });
                      },
                    ),
                  ),
                ],
                if (fidelityController.status.isEmpty || fidelityController.status.isError)... [
                  FidelityEmpty(
                    text: 'Nenhuma fidelidade encontrada',
                  ),
                ],
              ]
            ),
          ),
      ),
    );
  }

  Future<void> listFidelities() async {
    fidelityController.loading.value = true;
    await fidelityController.getFidelities();
    if (fidelityController.status.isSuccess || fidelityController.status.isEmpty) {
      fidelityController.loading.value = false;
      return;
    }
    fidelityController.loading.value = false;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Produtos',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          productController.status.errorMessage ?? 'Erro ao listar fidelidades',
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

  Future<void> saveProduct(BuildContext context) async {
    productController.loading.value = true;
    productController.product.value.fidelities = _selectedFidelities.map((e) => e.id).toList();
    await productController.saveProduct();
    if (productController.status.isSuccess) {
      productController.loading.value = false;
      Get.toNamed('/product/success');
      return;
    }
    productController.loading.value = false;
    showDialog(
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
