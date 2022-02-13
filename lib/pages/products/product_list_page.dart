import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';

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
      body: ProductListBody(),
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
          _searchField(),
          SizedBox(
            height: 20,
          ),
          _newProductBtn(),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 70,
            alignment: Alignment.center,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Image.asset(
                    'assets/img/productSquare.png',
                    height: 50,
                  ),
                ),
                Text("1"),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text("Nome"),
                ),
                Icon(Icons.arrow_left)
              ],
            ),
          ),
        ],
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
    Product product;
    for (int i = 0; i < 5; i++) {
      product = new Product();
      product.name = "name" + i.toString();
      product.id = i;
      products.products?.add(product);
    }
    return products;
  }
}
