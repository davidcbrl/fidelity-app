import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/pages/auth/login_success.dart';
import 'package:fidelity/pages/signup/sign_up.dart';
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

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  AuthController authController = Get.put(AuthController());
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _loadingController = false;

  @override
  Widget build(BuildContext context) {
    return (_loadingController)
      ? FidelityLoading(
          _loadingController,
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
                  height: 50,
                ),
                FidelityTextFieldMasked(
                  _emailController,
                  'E-mail',
                  'skywalker@jedi.com',
                  Icon(Icons.email_outlined),
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
                  _passwordController,
                  'Senha',
                  '*****',
                  Icon(Icons.lock_outline),
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
                      'Entrar',
                      () {
                        _authenticate(context);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FidelityTextButton(
                      'Não possui conta? Cadastre-se',
                      () {
                        Get.to(SignUpPage(), transition: Transition.rightToLeft);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }

  Future<void> _authenticate(BuildContext context) async {
    final FormState? form = _formKey.currentState;    
    if (form!.validate()) {
      setState(() => _loadingController = true);
      authController.email.value = _emailController.text;
      authController.password.value = _passwordController.text;
      await authController.auth();
      if (authController.status.isSuccess) {
        setState(() => _loadingController = false);
        Get.to(LoginSuccessPage(), transition: Transition.rightToLeft);
        return;
      }
      setState(() => _loadingController = false);
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
              padding: EdgeInsets.only(
                bottom: 10,
                left: 10,
                right: 10,
              ),
              child: FidelityButton(
                'OK',
                () {
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