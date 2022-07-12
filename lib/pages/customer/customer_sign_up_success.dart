import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class CustomerSignUpSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        imagePath: 'assets/img/customer.gif',
        title: 'Seja bem vindo!',
        description: 'Você está prestes a participar de programas de fidelidades nos seus estabelecimentos favoritos para receber promoções!',
        buttonText: 'Voltar para autenticação',
        onPressed: () {
          Get.offNamed('/auth');
        }
      ),
    );
  }
}