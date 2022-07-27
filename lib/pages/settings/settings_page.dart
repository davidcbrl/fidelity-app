import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
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
  final GetStorage box = GetStorage();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          FidelitySelectItem(
            icon: Icons.list,
            label: 'Perfil',
            description: 'Edite os dados do seu cadastro',
            onPressed: () {
              if (authController.user.value.type == 'E') {
                Get.toNamed('/settings/enterprise_profile');
                return;
              }
              Get.toNamed('/customer/profile');
            },
          ),
          SizedBox(
            height: 10,
          ),
          if (authController.user.value.type == 'E') ...[
            FidelitySelectItem(
              icon: Icons.supervised_user_circle_outlined,
              label: 'Funcionários',
              description: 'Gerencie perfis de funcionários',
              onPressed: () {
                Get.toNamed('/employee');
              },
            ),
            SizedBox(
              height: 10,
            ),
            FidelitySelectItem(
              icon: Icons.color_lens_outlined,
              label: 'Tema',
              description: 'Customize a aparência do app',
              onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
          ],
          FidelitySelectItem(
            icon: Icons.info_outline,
            label: 'Sobre',
            description: 'Visualize informações sobre o app',
            onPressed: () {
              Get.toNamed('/settings/about');
            },
          ),
          SizedBox(
            height: 10,
          ),
          FidelitySelectItem(
            icon: Icons.exit_to_app_outlined,
            label: 'Sair',
            description: 'Encerrar sua sessão',
            onPressed: () {
              logoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> logoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Sair',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          'Tem certeza que deseja sair?',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FidelityButton(
              label: 'Sim',
              onPressed: () {
                Get.back();
                authController.logout();
              },
            ),
          ),
          Center(
            child: FidelityTextButton(
              label: 'Não',
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
