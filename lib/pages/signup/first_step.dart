import 'package:fidelity/controllers/enterprise_controller.dart';
import 'package:fidelity/pages/signup/second_step.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_stepper.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstStepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Cadastro',
      ),
      body: FirstStepBody(),
    );
  }
}

class FirstStepBody extends StatefulWidget {
  @override
  _FirstStepBodyState createState() => _FirstStepBodyState();
}

class _FirstStepBodyState extends State<FirstStepBody> {
  TextEditingController _companyController = TextEditingController();
  TextEditingController _cpnjController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    EnterpriseController controller = new EnterpriseController();
    Get.put(controller);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                FidelityStepper(currentStep: 0),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Vamos começar com alguns dados essenciais sobre sua empresa, você poderá completar os dados posteriormente',
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
                SizedBox(
                  height: 20,
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
            controller: _companyController,
            label: 'Empresa',
            placeholder: 'Luke Skywalker LTDA',
            icon: Icon(Icons.apartment),
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
            controller: _cpnjController,
            label: 'CNPJ',
            placeholder: '00.000.000/0000-00',
            icon: Icon(Icons.business_center_outlined),
            mask: '##.###.###/####-##',
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
            controller: _contactController,
            label: 'Contato',
            placeholder: '(99) 9 9999-9999',
            icon: Icon(Icons.phone),
            mask: '(##) # ####-####',
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
    EnterpriseController enterpriseController = Get.find();

    return Column(
      children: [
        FidelityButton(
          label: 'Próximo',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              enterpriseController.signupEnterprise.value.name = _companyController.text;
              enterpriseController.signupEnterprise.value.cnpj = _cpnjController.text;
              enterpriseController.signupEnterprise.value.tel = _contactController.text;
              Get.to(() => SecondStepPage(), transition: Transition.cupertino);
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
