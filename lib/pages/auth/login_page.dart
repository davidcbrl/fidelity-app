import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_responsive_layout.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: FidelityResponsiveLayout(
        mobile: LoginBody(),
        desktop: Center(
          child: Container(
            width: 400,
            child: LoginBody(),
          ),
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => authController.loading.value
        ? FidelityLoading(
            loading: authController.loading.value,
            text: 'Entrando...',
          )
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/img/logo-text.png',
                        width: 125,
                      ),
                    ),
                    SizedBox(
                      height: 40,
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
                    SizedBox(
                      height: 20,
                    ),
                    FidelityTextFieldMasked(
                      controller: _passwordController,
                      label: 'Senha',
                      placeholder: '*****',
                      icon: Icon(Icons.lock_outline),
                      hideText: true,
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
                    FidelityTextButton(
                      label: 'Esqueci minha senha',
                      onPressed: () {
                        Get.toNamed('/auth/password_reset');
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        FidelityButton(
                          label: 'Entrar',
                          onPressed: () {
                            _authenticate(context);
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Não possui conta?',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FidelityTextButton(
                          label: 'Cadastre-se como empresa',
                          onPressed: () {
                            Get.toNamed('/signup/enterprise');
                          },
                        ),
                        FidelityTextButton(
                          label: 'Cadastre-se como cliente',
                          onPressed: () {
                            Get.toNamed('/signup/customer');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ),
    );
  }

  void _authenticate(BuildContext context) async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      authController.loading.value = true;
      authController.email.value = _emailController.text;
      authController.password.value = _passwordController.text;
      await authController.auth();
      if (authController.status.isSuccess) {
        authController.loading.value = false;
        Get.toNamed('/home');
        return;
      }
      authController.loading.value = false;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Autenticação',
            style: Theme.of(context).textTheme.headline1,
          ),
          content: Text(
            authController.status.errorMessage ?? 'Erro ao autenticar',
            style: Theme.of(context).textTheme.bodyText1,
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
