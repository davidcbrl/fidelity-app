import 'dart:convert';

import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/models/product.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:fidelity/widgets/fidelity_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Produtos',
        hasBackButton: false,
      ),
      body: Container(height: Get.height, child: ProductListBody()),
    );
  }
}

class ProductListBody extends StatefulWidget {
  @override
  State<ProductListBody> createState() => _ProductListBodyState();
}

class _ProductListBodyState extends State<ProductListBody> {
  ProductController productController = Get.put(ProductController());
  TextEditingController _textEditingController = new TextEditingController();
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        FidelityTextField(
          controller: _textEditingController,
          label: 'Filtrar',
          placeholder: 'Nome do produto',
          icon: Icon(Icons.search),
          onChanged: (value) {
            productController.filter.value = value;
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityButton(
          onPressed: () {
            productController.product.value = Product();
            Get.toNamed('/product/add');
          },
          label: 'Novo produto',
        ),
        SizedBox(
          height: 20,
        ),
        _productsList(),
      ],
    );
  }

  Widget _productsList() {
    return Expanded(
      child: Obx(
        () => LazyLoadScrollView(
          isLoading: productController.loading.value,
          scrollOffset: 10,
          onEndOfPage: () => productController.getProductsNextPage(),
          child: Container(
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
                      (Product product) => FidelitySelectItem(
                        id: product.id,
                        label: product.name ?? '',
                        image: product.image != null
                          ? Image.memory(
                              base64Decode(product.image ?? ''),
                              height: 50,
                              width: 50,
                            )
                          : Image.asset(
                              'assets/img/product.png',
                              height: 50,
                              width: 50,
                            ),
                        active: product.status ?? true,
                        onPressed: () {
                          productController.product.value = product;
                          Get.toNamed('/product/add');
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
      ),
    );
  }

  Future<void> _refresh() async {
    productController.page.value = 1;
    await productController.getProducts();
  }

  dynamic _scrollListener() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
