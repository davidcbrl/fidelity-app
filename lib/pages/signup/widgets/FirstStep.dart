import 'package:fidelity/pages/signup/widgets/CustomStepper.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FirstStep extends StatefulWidget {
  const FirstStep({
    Key? key,
  }) : super(key: key);

  @override
  _FirstStepState createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  TextEditingController _empresaController = TextEditingController();
  TextEditingController _cpnjController = TextEditingController();
  TextEditingController _contatoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: Get.height - 40,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset(
              "assets/img/fidelidadeText.png",
              width: 120,
            ),
            SizedBox(
              height: 20,
            ),
            CustomStepper(0),
            SizedBox(
              height: 20,
            ),
            Text(
              "Vamos começar com alguns dados essenciais sobre "
              "sua empresa, você poderá completar os dados posteriormente",
              style: TextStyle(fontSize: 17),
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
    );
  }

  Widget _fields() {
    return Container(
      child: Column(
        children: [
          FidelityTextFieldMasked(
            _empresaController,
            "Empresa",
            "Luke Skywalker LTDA",
            Icon(Icons.apartment),
            formatter: MaskTextInputFormatter(mask: ""),
            validator: (value) {
              if (value == null || value.isEmpty) return "Campo vazio";
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
            "CNPJ",
            "00.000.000/0000-00",
            Icon(Icons.business_center),
            formatter: MaskTextInputFormatter(mask: "##.###.###/####-##"),
            validator: (value) {
              if (value == null || value.isEmpty) return "Campo vazio";
            },
            onChanged: (value) {
              if (value.isNotEmpty) _formKey.currentState!.validate();
            },
          ),
          SizedBox(
            height: 20,
          ),
          FidelityTextFieldMasked(
            _contatoController,
            "Contato",
            "(99) 9 9999-9999",
            Icon(Icons.phone),
            formatter: MaskTextInputFormatter(mask: "(##) # ####-####"),
            validator: (value) {
              if (value == null || value.isEmpty) return "Campo vazio";
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
                "Próximo",
                () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
              ),
              FidelityTextButton(
                "Voltar",
                () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
