import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class CategorySuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        title: 'Categoria salva com sucesso!',
        description: 'Você pode utilizar essa categoria no cadastro de produtos.',
        buttonText: 'Voltar para a ajustes',
        onPressed: () {
          Get.off(() => HomePage(pageIndex: 4), transition: Transition.cupertino);
        }
      ),
    );
  }
}