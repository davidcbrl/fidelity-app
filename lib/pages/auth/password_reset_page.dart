import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordResetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Redefinir senha',
      ),
      body: Container(child: PasswordResetBody()),
    );
  }
}

class PasswordResetBody extends StatelessWidget {
  final AuthController authController = Get.find();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => authController.loading.value
      ? FidelityLoading(
          loading: authController.loading.value,
          text: 'Redefinindo senha...',
        )
      : Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Insira o e-mail vinculado à sua conta, enviaremos uma nova senha',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FidelityTextFieldMasked(
                    controller: _emailController,
                    label: 'E-mail',
                    placeholder: 'skywalker@jedi.com',
                    icon: Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo vazio';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) _formKey.currentState!.validate();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FidelityButton(
            label: 'Receber senha',
            onPressed: () {
              reset(context);
            },
          ),
          FidelityTextButton(
            label: 'Voltar',
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void reset(BuildContext context) async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      authController.loading.value = true;
      authController.email.value = _emailController.text;
      await authController.reset();
      if (authController.status.isSuccess) {
        authController.loading.value = false;
        Get.toNamed('/auth/reset_success');
        return;
      }
      authController.loading.value = false;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Redefinir senha',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            authController.status.errorMessage ?? 'Erro ao redefinir senha',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FidelityButton(
                label: 'OK',
                width: double.maxFinite,
                onPressed: () {
                  Get.back();
                }
              ),
            ),
          ],
        ),
      );
      return;
    }
  }
}
