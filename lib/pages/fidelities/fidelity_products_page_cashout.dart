import 'package:fidelity/controllers/fidelity_controller.dart';
import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/models/product.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_link_item.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FidelityProductsPageCashout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Deseja vincular um produto?',
      ),
      body: FidelityProductsCashoutBody(),
    );
  }
}

class FidelityProductsCashoutBody extends StatefulWidget {
  @override
  _FidelityProductsCashoutBodyState createState() => _FidelityProductsCashoutBodyState();
}

class _FidelityProductsCashoutBodyState extends State<FidelityProductsCashoutBody> {
  FidelityController fidelityController = Get.find();
  ProductController productController = Get.put(ProductController());
  List<int> _selectedProducts = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listProducts().whenComplete(() {
        fidelityController.loading.value = false;
        if (fidelityController.fidelity.value.id != null) if (fidelityController.fidelity.value.products!.length > 0) {
          fidelityController.fidelity.value.products!.toList().forEach((element) {
            _selectedProducts.add(element["Id"]);
          });
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => fidelityController.loading.value
          ? FidelityLoading(
              loading: fidelityController.loading.value,
              text: 'Carregando...',
            )
          : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Selecione os produtos que desejar vincular à esta fidelidade ou crie um novo produto',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FidelityButton(
                  label: 'Novo produto',
                  onPressed: () {
                    ProductController productController;

                    productController =
                        Get.isRegistered<ProductController>() ? Get.find<ProductController>() : ProductController();
                    Get.put(productController);
                    productController.product.value = Product();
                    productController.selectedImage.value = <int>[];
                    productController.isCreatingFidelity.value = true;
                    Get.toNamed('/product/add')?.whenComplete(() => productController.getProducts());
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                _productsList(),
                SizedBox(
                  height: 20,
                ),
                FidelityButton(
                  label: 'Concluir',
                  onPressed: () {
                    saveFidelity(context);
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

  Widget _productsList() {
    return Expanded(
      child: Obx(
        () => productController.loading.value
            ? FidelityLoading(
                loading: productController.loading.value,
                text: 'Carregando produtos...',
              )
            : SingleChildScrollView(
                child: Column(children: [
                  if (productController.status.isSuccess) ...[
                    ...productController.productsList.map(
                      (Product product) => FidelityLinkItem(
                        id: product.id ?? 1,
                        label: product.name ?? '',
                        selected: _selectedProducts.contains(product.id),
                        active: product.status ?? true,
                        onPressed: () {
                          if (_selectedProducts.contains(product.id)) {
                            setState(() {
                              _selectedProducts.remove(product.id);
                            });
                            return;
                          }
                          setState(() {
                            _selectedProducts.add(product.id!);
                          });
                        },
                      ),
                    ),
                  ],
                  if (productController.status.isEmpty || productController.status.isError) ...[
                    FidelityEmpty(
                      text: 'Nenhum produto encontrado',
                    ),
                  ],
                ]),
              ),
      ),
    );
  }

  Future<void> listProducts() async {
    productController.loading.value = true;
    await productController.getProducts();
    if (productController.status.isSuccess || productController.status.isEmpty) {
      productController.loading.value = false;
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
          productController.status.errorMessage ?? 'Erro ao listar produtos',
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

  Future<void> saveFidelity(BuildContext context) async {
    fidelityController.fidelity.value.productList = _selectedProducts;

    fidelityController.loading.value = true;
    fidelityController.fidelity.value.promotionTypeId == 1
        ? fidelityController.fidelity.value.productId = null
        : fidelityController.fidelity.value.couponValue = null;
    await fidelityController.saveFidelity();
    if (fidelityController.status.isSuccess) {
      fidelityController.loading.value = false;
      Get.toNamed('/fidelity/success');
      return;
    }
    fidelityController.loading.value = false;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Fidelidades',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          fidelityController.status.errorMessage ?? 'Erro ao salvar fidelidade',
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
