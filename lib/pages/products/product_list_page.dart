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
      ),
      body: Container(height: Get.height, child: SingleChildScrollView(child: ProductListBody())),
    );
  }
}

class ProductListBody extends StatelessWidget {
  final TextEditingController _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20,),
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
              child: product.photo != null
                  ? Image.network(product.photo!)
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
            Icon(Icons.arrow_right)
          ],
        ),
      ),
    );
  }

  Container _newProductBtn() {
    return Container(
      child: FidelityButton(
        onPressed: () {},
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
}
