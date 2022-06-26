import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class CustomerSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        title: 'Perfil salvo com sucesso!',
        description: 'As informações foram atualizadas e estão disponíveis para os estabelecimentos',
        buttonText: 'Voltar para ajustes',
        onPressed: () {
          Get.off(() => HomePage(pageIndex: 3), transition: Transition.cupertino);
        }
      ),
    );
  }
}