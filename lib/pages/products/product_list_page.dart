import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/pages/products/product_add_page.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
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
      body: Container(height: Get.height, child: SingleChildScrollView(child: ProductListBody())),
    );
  }
}

class ProductListBody extends StatefulWidget {
  const ProductListBody({ Key? key }) : super(key: key);

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
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          _searchField(),
          SizedBox(
            height: 20,
          ),
          _newProductBtn(),
          SizedBox(
            height: 20,
          ),
          Column(
            children: _fakeGetList().products!.map((e) => productByProduct(e)).toList(),
          ),
        ],
      ),
    );
  }

  Widget productByProduct(Product product) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        height: 70,
        alignment: Alignment.center,
        color: Colors.white,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: product.image != null
                  ? Image.network(product.image!)
                  : Image.asset(
                      'assets/img/productSquare.png',
                      height: 50,
                    ),
            ),
            SizedBox(
              width: 20,
            ),
            Text("1"),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(product.name!),
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  Container _newProductBtn() {
    return Container(
      child: FidelityButton(
        onPressed: () {
          Get.to(ProductAddPage(), transition: Transition.cupertino);
        },
        label: "Novo produto",
      ),
    );
  }

  Container _searchField() {
    return Container(
      height: 45,
      child: FidelityTextField(
          controller: _textEditingController,
          label: "Filtrar",
          placeholder: "Nome do produto",
          icon: Icon(Icons.search)),
    );
  }

  ProductEntries _fakeGetList() {
    ProductEntries products = new ProductEntries();
    products.products = new List.generate(10, (index) {
      Product product = new Product();
      product.name = "nome" + index.toString();
      product.id = index;
      return product;
    });

    return products;
  }

  Future<void> listProducts() async {
    await productController.getList();
    if (productController.status.isSuccess) {
      return;
    }
    print('DEU ERRO');
    // showDialog(context: context, builder: builder)
  }
}
