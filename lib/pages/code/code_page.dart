import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';

class CodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Escanear Código QR',
      ),
      body: CodeBody(),
    );
  }
}

class CodeBody extends StatefulWidget {
  @override
  _CodeBodyState createState() => _CodeBodyState();
}

class _CodeBodyState extends State<CodeBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}