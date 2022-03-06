import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/pages/products/product_add_page.dart';
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

class ProductListBody extends StatefulWidget {
  @override
  _ProductListBodyState createState() => _ProductListBodyState();
}

class _ProductListBodyState extends State<ProductListBody> {
  ProductController productController = Get.put(ProductController());
  TextEditingController _textEditingController = new TextEditingController();

  void initState() {
    listProducts();
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
        ),
        SizedBox(
          height: 20,
        ),
        FidelityButton(
          onPressed: () {
            Get.to(() => ProductAddPage(), transition: Transition.cupertino);
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
}
