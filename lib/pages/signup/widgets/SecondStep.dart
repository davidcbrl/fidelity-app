import 'package:fidelity/widgets/CustomStepper.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SecondStep extends StatefulWidget {
  const SecondStep({
    Key? key,
  }) : super(key: key);

  @override
  _SecondStepState createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
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
              Image.asset(
                "assets/img/fidelidadeText.png",
                width: 120,
              ),
              SizedBox(
                height: 20,
              ),
              CustomStepper(1),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: Text(
                  "Agora, informe seu e-mail e uma senha, serão os dados utilizados para acessar o app",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
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
            "E-mail",
            "skywalker@jedi.com",
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
            _senhaController,
            "Senha",
            "*****",
            Icon(Icons.lock),
            formatter: MaskTextInputFormatter(mask: ""),
            hideText: true,
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
            _confirmController,
            "Confirmação",
            "*****",
            Icon(Icons.lock),
            formatter: MaskTextInputFormatter(mask: ""),
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
