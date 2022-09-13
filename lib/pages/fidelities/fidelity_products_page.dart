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
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class FidelityProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Vale Produto',
      ),
      body: FidelityProductsBody(),
    );
  }
}

class FidelityProductsBody extends StatefulWidget {
  @override
  _FidelityProductsBodyState createState() => _FidelityProductsBodyState();
}

class _FidelityProductsBodyState extends State<FidelityProductsBody> {
  FidelityController fidelityController = Get.find();
  ProductController productController = Get.put(ProductController());
  int _selectedItem = -99;
  late ScrollController scrollController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listProducts();
      if (fidelityController.fidelity.value.productId != null)
        _selectedItem = fidelityController.fidelity.value.productId!;
    });
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  dynamic _scrollListener() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => fidelityController.loading.value
          ? FidelityLoading(
              loading: fidelityController.loading.value,
              text: 'Salvando fidelidade...',
            )
          : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Informe qual produto será a considerado como a promoção do cliente',
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
                  label: 'Proximo',
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
        () => LazyLoadScrollView(
          isLoading: productController.loading.value,
          scrollOffset: 10,
          onEndOfPage: () => productController.getProductsNextPage(),
          child: RefreshIndicator(
            onRefresh: () => _refresh(),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                if (!productController.status.isError && productController.productsList.length > 0) ...[
                  ...productController.productsList.map(
                    (Product product) => FidelityLinkItem(
                      id: product.id ?? 1,
                      label: product.name ?? '',
                      selected: product.id == _selectedItem,
                      active: product.status ?? true,
                      onPressed: () {
                        if (_selectedItem != product.id)
                          setState(() {
                            _selectedItem = product.id!;
                          });
                        else
                          setState(() {
                            _selectedItem = -99;
                          });
                        return;
                      },
                    ),
                  ),
                ],
                if (productController.status.isLoading)
                  FidelityLoading(
                    loading: productController.loading.value,
                    text: 'Carregando produtos...',
                  ),
                if (productController.status.isEmpty)
                  FidelityEmpty(
                    text: 'Nenhum produto encontrado',
                  ),
                if (productController.status.isError)
                  FidelityEmpty(
                    text: productController.status.errorMessage ?? '500',
                  ),
              ],
            ),
          ),
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

  Future<void> _refresh() async {
    productController.page.value = 1;
    await productController.getProducts();
  }

  Future<void> saveFidelity(BuildContext context) async {
    fidelityController.loading.value = true;
    if (_selectedItem != -99)
      fidelityController.fidelity.value.productId =
          productController.productsList.firstWhere((element) => element.id == _selectedItem).id;
    Get.toNamed('/fidelity/cashout');
  }
}
