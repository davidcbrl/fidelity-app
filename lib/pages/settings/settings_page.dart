import 'package:fidelity/pages/auth/login.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Ajustes',
        hasBackButton: false,
      ),
      body: Container(child: SettingsBody()),
    );
  }
}

class SettingsBody extends StatelessWidget {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          FidelitySelectItem(
            label: 'Perfil',
            description: 'Edite os dados do seu cadastro',
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          ),
          FidelitySelectItem(
            label: 'Funcionários',
            description: 'Gerencie perfis de funcionários',
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          ),
          FidelitySelectItem(
            label: 'Tema',
            description: 'Customize a aparência do app',
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          ),
          FidelitySelectItem(
            label: 'Sobre',
            description: 'Visualize informações sobre o app',
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          ),
          FidelitySelectItem(
            label: 'Sair',
            description: 'Encerrar sua sessão',
            onPressed: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  void logout() {
    if (box.hasData('jwt')) {
      box.remove('jwt');
    }
    if (box.hasData('companyId')) {
      box.remove('companyId');
    }
    Get.offAll(() => LoginPage(), transition: Transition.rightToLeft);
  }
}
