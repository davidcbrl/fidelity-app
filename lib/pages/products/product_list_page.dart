import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product.dart';
import '../../widgets/fidelity_appbar.dart';
import '../../widgets/fidelity_button.dart';
import '../../widgets/fidelity_text_field.dart';

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

class ProductListBody extends StatelessWidget {
  ProductController productController = Get.put(ProductController());
  TextEditingController _textEditingController = new TextEditingController();

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
        ),
        SizedBox(
          height: 20,
        ),
        FidelityButton(
          onPressed: () {
            Get.toNamed('/product');
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
    return Obx(
      () => productController.loading.value
      ? FidelityLoading(
          loading: productController.loading.value,
          text: 'Carregando produtos...',
        )
      : Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (productController.status.isSuccess)... [
                ...productController.productsList.map(
                  (Product product) => FidelitySelectItem(
                    id: product.id,
                    label: product.name ?? '',
                    image: Image.asset(
                      'assets/img/product.png',
                      height: 50,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
              if (productController.status.isEmpty || productController.status.isError)... [
                FidelityEmpty(
                  text: 'Nenhum produto encontrado',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
