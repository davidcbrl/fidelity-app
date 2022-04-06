import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class ResetSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        title: 'Verifique sua caixa de entrada',
        description: 'Enviamos uma nova senha no e-mail informado. Utilize essa senha para acessar o app.',
        buttonText: 'Voltar para a autenticação',
        onPressed: () {
          Get.offNamed('/auth');
        }
      ),
    );
  }
}