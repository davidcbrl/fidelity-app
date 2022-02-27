import 'package:fidelity/controllers/customer_signup_controller.dart';
import 'package:fidelity/models/user.dart';
import 'package:fidelity/pages/auth/login.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/customer.dart';
import '../../widgets/fidelity_button.dart';
import '../../widgets/fidelity_text_button.dart';
import '../../widgets/fidelity_text_field_masked.dart';

class CustomerSignupPage extends StatelessWidget {
  const CustomerSignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: Container(height: Get.height, child: CustomerSignupBody()),
    );
  }
}

class CustomerSignupBody extends StatelessWidget {
  CustomerSignupController controller = Get.put(CustomerSignupController());
  TextEditingController _cpfController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  final _formCustomerSignupKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/img/fidelity-text.png',
                    width: 100,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Insira seus dados para criar uma conta',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formCustomerSignupKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    FidelityTextFieldMasked(
                      controller: _cpfController,
                      label: 'CPF',
                      placeholder: '000.000.000-00',
                      icon: Icon(Icons.tag),
                      mask: '###.###.###-##',
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo vazio';
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) _formCustomerSignupKey.currentState!.validate();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FidelityTextFieldMasked(
                      controller: _nameController,
                      label: 'Nome',
                      placeholder: 'Chewie',
                      icon: Icon(Icons.person_outline),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo vazio';
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) _formCustomerSignupKey.currentState!.validate();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FidelityTextFieldMasked(
                      controller: _emailController,
                      label: 'Email',
                      placeholder: 'chewie@wookie.com',
                      icon: Icon(Icons.email_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo vazio';
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) _formCustomerSignupKey.currentState!.validate();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FidelityTextFieldMasked(
                      controller: _passwordController,
                      label: 'Senha',
                      placeholder: '*****',
                      hideText: true,
                      icon: Icon(Icons.lock_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo vazio';
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) _formCustomerSignupKey.currentState!.validate();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FidelityTextFieldMasked(
                      controller: _confirmPasswordController,
                      label: 'Confirmação',
                      placeholder: '*****',
                      hideText: true,
                      icon: Icon(Icons.lock_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo vazio';
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) _formCustomerSignupKey.currentState!.validate();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          FidelityButton(
            label: 'Salvar',
            onPressed: () async {
              saveCustomer(context);
            }
          ),
          FidelityTextButton(
            label: 'Voltar',
            onPressed: () {
              Get.back();
            }
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void saveCustomer(BuildContext context) async {
    final FormState? form = _formCustomerSignupKey.currentState;
    if (form!.validate()) {
      controller.loading.value = true;
      User user = new User(
        email: _emailController.text,
        password: _passwordController.text,
        customer: new Customer(
          name: _nameController.text,
          cpf: _cpfController.text,
        ),
      );
      await controller.signup(user);
      if (controller.status.isSuccess) {
        controller.loading.value = false;
        Get.to(() => LoginPage(), transition: Transition.leftToRight);
        return;
      }
      controller.loading.value = false;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Cadastrar-se como cliente',
            style: Theme.of(context).textTheme.headline1,
          ),
          content: Text(
            controller.status.errorMessage ?? 'Erro ao cadastrar',
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
