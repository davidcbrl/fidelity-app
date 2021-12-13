import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';

class FidelityListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Fidelidades',
      ),
      body: FidelityListBody(),
    );
  }
}

class FidelityListBody extends StatefulWidget {
  @override
  _FidelityListBodyState createState() => _FidelityListBodyState();
}

class _FidelityListBodyState extends State<FidelityListBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}