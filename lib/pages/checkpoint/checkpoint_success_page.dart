import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class CheckpointSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        imagePath: 'assets/img/ok.png',
        title: 'Checkpoint realizado com sucesso!',
        description: 'O progresso das fidelidades do cliente foi atualizado!',
        buttonText: 'Voltar para checkpoint',
        onPressed: () {
          Get.off(() => HomePage(pageIndex: 2), transition: Transition.cupertino);
        }
      ),
    );
  }
}