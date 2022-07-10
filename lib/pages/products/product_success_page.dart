import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class ProductSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        title: 'Produto salvo com sucesso!',
        description: 'Este produto já está disponível para seus clientes com as fidelidades que você já vinculou.',
        buttonText: 'Voltar para a lista',
        onPressed: () {
          Get.off(() => HomePage(pageIndex: 3), transition: Transition.cupertino);
        }
      ),
    );
  }
}