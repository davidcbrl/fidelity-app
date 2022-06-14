import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class CheckpointCompletedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        imagePath: 'assets/img/completed.gif',
        title: 'Fidelidade completa!',
        description: 'Este cliente completou todas a condições da fidelidade e já pode receber a promoção',
        buttonText: 'Voltar para checkpoint',
        onPressed: () {
          Get.off(() => HomePage(pageIndex: 2), transition: Transition.cupertino);
        }
      ),
    );
  }
}