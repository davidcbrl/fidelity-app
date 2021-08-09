import 'package:fidelity/pages/auth/login_page.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        'Parabéns! Você acaba de adquirir o melhor sistema de gestão de fidelidades do mercado!',
        'Pronto para aumentar o engajamento de seus clientes e alavancar seu negócio? Então, vamos começar os trabalhos!',
        'Começar os trabalhos',
        () {
          Get.offAll(LoginPage(), transition: Transition.leftToRight);
        }
      ),
    );
  }
}