import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';

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

class ProductListBody extends StatefulWidget {
  @override
  _ProductListBodyState createState() => _ProductListBodyState();
}

class _ProductListBodyState extends State<ProductListBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}