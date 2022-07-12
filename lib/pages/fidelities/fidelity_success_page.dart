import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class FidelitySuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        title: 'Fidelidade salva com sucesso!',
        description: 'Esta fidelidade já está disponível para seus clientes com os produtos que você já vinculou.',
        buttonText: 'Voltar para a lista',
        onPressed: () {
          Get.off(() => HomePage(pageIndex: 1), transition: Transition.cupertino);
        }
      ),
    );
  }
}