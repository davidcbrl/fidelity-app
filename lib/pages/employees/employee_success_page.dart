import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';
import 'package:fidelity/widgets/fidelity_success.dart';
import 'package:get/get.dart';

class EmployeeSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelitySuccess(
        title: 'Funcionário salvo com sucesso!',
        description: 'Utilize o e-mail e senha que você definiu para acessar o app como este funcionário.',
        buttonText: 'Voltar para a ajustes',
        onPressed: () {
          Get.off(() => HomePage(pageIndex: 4), transition: Transition.cupertino);
        }
      ),
    );
  }
}