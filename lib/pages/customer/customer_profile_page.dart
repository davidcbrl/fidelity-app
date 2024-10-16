import 'dart:convert';
import 'dart:typed_data';

import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/controllers/customer_controller.dart';
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

class CustomerProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Perfil',
      ),
      body: CustomerProfileBody(),
    );
  }
}

class CustomerProfileBody extends StatefulWidget {
  const CustomerProfileBody({ Key? key }) : super(key: key);

  @override
  State<CustomerProfileBody> createState() => _CustomerProfileBodyState();
}

class _CustomerProfileBodyState extends State<CustomerProfileBody> {
  AuthController authController = Get.find();
  CustomerController customerController = Get.find();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _nameController = TextEditingController(text: '');
  TextEditingController _cpfController = TextEditingController(text: '');
  TextEditingController _passwordController = new TextEditingController(text: '');
  TextEditingController _confirmPasswordController = new TextEditingController(text: '');
  ImagePicker _picker = ImagePicker();
  var _selectedImage;

  @override
  void initState() {
    if (authController.user.value.id != null) {
      _emailController.text = authController.user.value.email ?? '';
      _nameController.text = authController.user.value.name ?? '';
      _cpfController.text = authController.user.value.customer!.cpf ?? '';
      _selectedImage = authController.user.value.image != null
        ? base64Decode(authController.user.value.image ?? '')
        : null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => customerController.loading.value
      ? FidelityLoading(
          loading: customerController.loading.value,
          text: 'Salvando perfil...',
        )
      : Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Edite os dados do seu cadastro',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _formFields(),
          SizedBox(
            height: 20,
          ),
          FidelityButton(
            label: 'Salvar',
            onPressed: () {
              saveCustomer(context);
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
    );
  }

  Widget _formFields() {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FidelityImagePicker(
                image: authController.selectedImage.length > 0
                  ? Uint8List.fromList(authController.selectedImage)
                  : _selectedImage,
                label: 'Toque para trocar a foto',
                emptyImagePath: 'assets/img/user.jpg',
                onSelect: () async {
                  XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
                  authController.selectedImage.value = await picked!.readAsBytes();
                },
              ),
              SizedBox(
                height: 20,
              ),
              FidelityTextFieldMasked(
                controller: _emailController,
                label: 'E-mail',
                placeholder: 'chewie@wookie.com',
                icon: Icon(Icons.email_outlined),
                readOnly: true,
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
                controller: _nameController,
                label: 'Nome',
                placeholder: 'Chewie',
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
                controller: _cpfController,
                label: 'CPF',
                placeholder: '000.000.000-00',
                icon: Icon(Icons.tag),
                mask: '###.###.###-##',
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
              Text(
                'Redefinir senha?',
                style: Theme.of(context).textTheme.labelMedium,
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
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveCustomer(BuildContext context) async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      customerController.loading.value = true;
      String _imageController = '';
      if (authController.selectedImage.length > 0) {
        List<int> imageBytes = authController.selectedImage;
        _imageController = base64Encode(imageBytes);
      }
      if (_passwordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty) {
        authController.user.value.password = _passwordController.text;
      }
      authController.user.value.email = _emailController.text;
      authController.user.value.name = _nameController.text;
      authController.user.value.customer!.cpf = _cpfController.text;
      authController.user.value.image = _imageController.isNotEmpty ? _imageController : null;
      await customerController.saveCustomer(authController.user.value);
      if (customerController.status.isSuccess) {
        customerController.loading.value = false;
        Get.toNamed('/customer/profile/success');
        return;
      }
      customerController.loading.value = false;
      _showErrorDialog(context);
    }
  }

  Future<dynamic> _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Perfil',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          authController.status.errorMessage ?? 'Erro ao salvar perfil',
          style: Theme.of(context).textTheme.labelMedium,
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
