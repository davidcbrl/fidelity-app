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
        'Produto criado com sucesso!',
        'Este produto já está disponível para seus clientes com as fidelidades que você já vinculou.',
        'Voltar para a lista',
        () {
          Get.off(() => HomePage(pageIndex: 3), transition: Transition.leftToRight);
        }
      ),
    );
  }
}