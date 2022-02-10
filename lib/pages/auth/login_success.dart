import 'package:fidelity/pages/auth/login.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class LoginSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        'Login realizado com successo!',
        'Essa é uma tela temporária para sucesso na autenticação. Dashboard em construção.',
        'Voltar para autenticação',
        () {
          Get.offAll(LoginPage(), transition: Transition.leftToRight);
        }
      ),
    );
  }
}