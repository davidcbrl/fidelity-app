import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/pages/home/home.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: LoginBody(),
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
      () => authController.loadingController.value
          ? FidelityLoading(
              loading: authController.loadingController.value,
              text: 'Entrando...',
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/img/logo.png',
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/img/fidelity-text.png',
                        width: 100,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FidelityTextFieldMasked(
                      controller: _emailController,
                      label: 'E-mail',
                      placeholder: 'skywalker@jedi.com',
                      icon: Icon(Icons.email_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo vazio';
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
                        if (value == null || value.isEmpty) return 'Campo vazio';
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) _formKey.currentState!.validate();
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
                          height: 20,
                        ),
                        FidelityTextButton(
                          label: 'Não possui conta? Cadastre-se',
                          onPressed: () {
                            //Get.to(SignUpPage(), transition: Transition.rightToLeft);
                            Get.toNamed("/customer/signup");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _authenticate(BuildContext context) async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      authController.loadingController.value = true;
      authController.email.value = _emailController.text;
      authController.password.value = _passwordController.text;
      await authController.auth();
      if (authController.status.isSuccess) {
        authController.loadingController.value = false;
        Get.to(HomePage(), transition: Transition.rightToLeft);
        return;
      }
      authController.loadingController.value = false;
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
                  }),
            ),
          ],
        ),
      );
      return;
    }
  }
}
