import 'package:fidelity/pages/signup/sign_up_page.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          FidelityTextField(
            _emailController,
            'E-mail',
            'skywalker@jedi.com',
            Icon(
              Icons.person_outline,
              size: 20,
            )
          ),
          SizedBox(
            height: 20,
          ),
          FidelityTextField(
            _passwordController,
            'Senha',
            '*****',
            Icon(
              Icons.lock_outline,
              size: 20,
            ),
            hideText: true,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    child: Checkbox(
                      value: true,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (value) {
                        print(value);
                      }
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Lembrar e-mail e senha',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Text(
                'Esqueci minha senha',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              FidelityButton(
                'Entrar',
                () {
                  print('Click');
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
    );
  }
}