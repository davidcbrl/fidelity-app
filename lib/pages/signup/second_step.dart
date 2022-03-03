import 'package:fidelity/controllers/enterprise_controller.dart';
import 'package:fidelity/pages/signup/third_step.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_stepper.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondStepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Cadastro',
      ),
      body: SecondStepBody(),
    );
  }
}

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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                FidelityStepper(currentStep: 1),
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
              ],
            ),
          ),
        ),
        _navigationButtons(),
      ],
    );
  }

  Widget _fields() {
    return Container(
      child: Column(
        children: [
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
            height: 20,
          ),
          FidelityTextFieldMasked(
            controller: _confirmController,
            label: 'Confirmação',
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
        ],
      ),
    );
  }

  Widget _navigationButtons() {
    EnterpriseController controller = Get.find();

    return Column(
      children: [
        FidelityButton(
          label: 'Próximo',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.userSignup.value.email = _emailController.text;
              controller.userSignup.value.password = _passwordController.text;
              Get.to(() => ThirdStepPage(), transition: Transition.cupertino);
            }
          },
        ),
        FidelityTextButton(
          label: 'Voltar',
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
