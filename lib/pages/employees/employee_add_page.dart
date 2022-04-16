import 'dart:convert';
import 'dart:typed_data';

import 'package:fidelity/controllers/employee_controller.dart';
import 'package:fidelity/models/employee.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_image_picker.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Novo funcionário',
      ),
      body: EmployeePageBody(),
    );
  }
}

class EmployeePageBody extends StatefulWidget {
  @override
  State<EmployeePageBody> createState() => _EmployeePageBodyState();
}

class _EmployeePageBodyState extends State<EmployeePageBody> {
  EmployeeController employeeController = Get.put(EmployeeController());
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _activeController = true;
  ImagePicker _picker = ImagePicker();
  var _selectedImage;

  @override
  void initState() {
    if (employeeController.employee.value.employee?.id != null) {
      _nameController.text = employeeController.employee.value.employee!.name ?? '';
      _emailController.text = employeeController.employee.value.email ?? '';
      _passwordController.text = employeeController.employee.value.password ?? '';
      _activeController = employeeController.employee.value.active!;
      _selectedImage = employeeController.employee.value.image != null
        ? base64Decode(employeeController.employee.value.image ?? '')
        : null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => employeeController.loading.value
      ? FidelityLoading(
          loading: employeeController.loading.value,
          text: 'Salvando funcionário...',
        )
      : Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: _formFields(context),
                  ),
                ),
              ),
              FidelityButton(
                label: 'Próximo',
                onPressed: () {
                  saveEmployee(context);
                },
              ),
              FidelityTextButton(
                label: 'Voltar',
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
    );
  }

  Widget _formFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FidelityTextFieldMasked(
          controller: _nameController,
          label: 'Nome',
          placeholder: 'Obi Wan',
          icon: Icon(Icons.person_outline),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) _formKey.currentState!.validate();
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityTextFieldMasked(
          controller: _emailController,
          label: 'E-mail',
          placeholder: 'obiwan@jedi.com',
          icon: Icon(Icons.email_outlined),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
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
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) _formKey.currentState!.validate();
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityImagePicker(
          image: employeeController.selectedImage.length > 0
              ? Uint8List.fromList(employeeController.selectedImage)
              : _selectedImage,
          label: 'Foto do produto',
          emptyImagePath: 'assets/img/user.jpg',
          onSelect: () async {
            XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
            employeeController.selectedImage.value = await picked!.readAsBytes();
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Switch(
              value: _activeController,
              onChanged: (value) {
                setState(() {
                  _activeController = value;
                });
              },
            ),
            Text(
              "Funcionário ativo",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Future<void> saveEmployee(BuildContext context) async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      employeeController.loading.value = true;
      String _imageController = '';
      if (employeeController.selectedImage.length > 0) {
        List<int> imageBytes = employeeController.selectedImage;
        _imageController = base64Encode(imageBytes);
      }
      employeeController.employee.value.employee = employeeController.employee.value.employee ?? Employee();
      employeeController.employee.value.employee!.name = _nameController.text;
      employeeController.employee.value.email = _emailController.text;
      employeeController.employee.value.password = _passwordController.text;
      employeeController.employee.value.active = _activeController;
      employeeController.employee.value.image = _imageController.isNotEmpty ? _imageController : null;
      await employeeController.saveEmployee();
      if (employeeController.status.isSuccess) {
        employeeController.loading.value = false;
        Get.toNamed('/employee/success');
        return;
      }
      employeeController.loading.value = false;
      _showErrorDialog(context);
    }
  }

  Future<dynamic> _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Funcionários',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          employeeController.status.errorMessage ?? 'Erro ao salvar funcionário',
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
              },
            ),
          ),
        ],
      ),
    );
  }
}