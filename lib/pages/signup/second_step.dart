import 'package:fidelity/pages/signup/third_step.dart';
import 'package:fidelity/widgets/fidelity_stepper.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondStepBody extends StatefulWidget {
  @override
  _SecondStepBodyState createState() => _SecondStepBodyState();
}

class _SecondStepBodyState extends State<SecondStepBody> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height - 40,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Cadastro',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 20,
              ),
              FidelityStepper(1),
              SizedBox(
                height: 20,
              ),
              Text(
                'Agora, informe seu e-mail e uma senha, serão os dados utilizados para acessar o app',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: _fields(),
              ),
              _navigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fields() {
    return Container(
      child: Column(
        children: [
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
            height: 20,
          ),
          FidelityTextFieldMasked(
            _confirmController,
            'Confirmação',
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
        ],
      ),
    );
  }

  Widget _navigationButtons() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 90,
          child: Column(
            children: [
              FidelityButton(
                'Próximo',
                () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => ThirdStepBody(),
                      ),
                    );
                  }
                },
              ),
              FidelityTextButton(
                'Voltar',
                () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
