import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SettingItem("Perfil", "Visualize os dados sobre o seu cadastro"),
          SizedBox(
            height: 10,
          ),
          SettingItem("Funcionarios", "Gerencie perfis de funcionarios"),
          SizedBox(
            height: 10,
          ),
          SettingItem("Tema", "Customize a aparencia do app"),
          SizedBox(
            height: 10,
          ),
          SettingItem("Sobre", "Visualize informacoes sobre o app"),
          SizedBox(
            height: 10,
          ),
          SettingItem("Sair", "Encerrar sua sessao"),
        ],
      ),
    );
  }

  Widget SettingItem(String name, String desc) {
    return Container(
      child: Container(
        height: 70,
        alignment: Alignment.center,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(name!),
                      SizedBox(
                        width: 20,
                      ),
                      // Text(
                      //   "Acesso restrito*",
                      //   style: TextStyle(color: Colors.red),
                      // )
                    ],
                  ),
                  Text(desc!),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
