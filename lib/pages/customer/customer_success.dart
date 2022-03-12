import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class CustomerSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        imagePath: 'assets/img/customer.gif',
        title: 'Em breve!',
        description: 'O módulo de clientes está em construção, em breve você poderá controlar suas fidelidades na palma da mão!',
        buttonText: 'Voltar para autenticação',
        onPressed: () {
          Get.offNamed('/auth');
        }
      ),
    );
  }
}