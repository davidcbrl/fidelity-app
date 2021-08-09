import 'package:fidelity/pages/signup/second_step_body.dart';
import 'package:fidelity/widgets/fidelity_stepper.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Container(
      child: SingleChildScrollView(
        child: Container(
          height: Get.height - 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
              FidelityStepper(0),
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
            _companyController,
            'Empresa',
            'Luke Skywalker LTDA',
            Icon(Icons.apartment),
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
            _cpnjController,
            'CNPJ',
            '00.000.000/0000-00',
            Icon(Icons.business_center_outlined),
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
            _contactController,
            'Contato',
            '(99) 9 9999-9999',
            Icon(Icons.phone),
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
                        builder: (context) => SecondStepBody()
                      )
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
