import 'dart:convert';
import 'dart:typed_data';

import 'package:fidelity/controllers/enterprise_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_image_picker.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EnterpriseProfilePage extends StatelessWidget {
  const EnterpriseProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Perfil da Empresa',
      ),
      body: EnterpriseProfileBody(),
    );
  }
}

class EnterpriseProfileBody extends StatefulWidget {
  EnterpriseProfileBody({Key? key}) : super(key: key);

  @override
  State<EnterpriseProfileBody> createState() => _EnterpriseProfileBodyState();
}

class _EnterpriseProfileBodyState extends State<EnterpriseProfileBody> {
  EnterpriseController enterpriseController = Get.put(EnterpriseController());
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _cnpjController = new TextEditingController();
  TextEditingController _contactController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _addressNumberController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _ufController = new TextEditingController();
  TextEditingController _ramoController = new TextEditingController();
  ImagePicker _picker = ImagePicker();
  var _selectedImage;

  final _formEnterpriseSignupKey = GlobalKey<FormState>();

  @override
  void initState() {
    _selectedImage = enterpriseController.profileEnterprise.value.image != null
        ? base64Decode(enterpriseController.profileEnterprise.value.image ?? '')
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => enterpriseController.loading.value
          ? FidelityLoading(loading: enterpriseController.loading.value)
          : Container(
              child: Expanded(
                child: SingleChildScrollView(
                  child: Form(child: _formFields()),
                ),
              ),
            ),
    );
  }

  Widget _formFields() {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        FidelitySelectItem(
            label: 'Plano Avancado',
            description: 'Todas as vantagens do plano Simples + destaque para clientes e cadastros ilimitados',
            onPressed: () {}),
        SizedBox(
          height: 10,
        ),
        FidelityImagePicker(
          size: 100,
          image: enterpriseController.selectedImage.length > 0
              ? Uint8List.fromList(enterpriseController.selectedImage)
              : _selectedImage,
          label: 'Toque para trocar a foto',
          emptyImagePath: 'assets/img/product.png',
          onSelect: () async {
            XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
            enterpriseController.selectedImage.value = await picked!.readAsBytes();
          },
        ),
        SizedBox(
          height: 10,
        ),
        FidelityTextFieldMasked(
          controller: _emailController,
          label: 'Email',
          placeholder: 'chewie@wookie.com',
          icon: Icon(Icons.email_outlined),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) _formEnterpriseSignupKey.currentState!.validate();
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityTextFieldMasked(
          controller: _nameController,
          label: 'Empresa',
          placeholder: 'Chewie',
          icon: Icon(Icons.person_outline),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) _formEnterpriseSignupKey.currentState!.validate();
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityTextFieldMasked(
          controller: _cnpjController,
          label: 'CNPJ',
          placeholder: '00.000.000/0000-00',
          icon: Icon(Icons.tag),
          mask: '##.###.###/####-##',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) _formEnterpriseSignupKey.currentState!.validate();
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityTextFieldMasked(
          controller: _contactController,
          label: 'Contato',
          mask: '(##)# ####-####',
          placeholder: '(99)9 9999-9999',
          icon: Icon(Icons.phone),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) _formEnterpriseSignupKey.currentState!.validate();
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityTextFieldMasked(
          controller: _addressController,
          label: 'Endereco',
          placeholder: 'The force street',
          icon: Icon(Icons.phone),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) _formEnterpriseSignupKey.currentState!.validate();
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityTextFieldMasked(
          controller: _addressNumberController,
          label: 'Número',
          placeholder: '123',
          icon: Icon(Icons.house),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) _formEnterpriseSignupKey.currentState!.validate();
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityTextFieldMasked(
          controller: _cityController,
          label: 'Cidade',
          placeholder: 'Arkanis',
          icon: Icon(Icons.house),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) _formEnterpriseSignupKey.currentState!.validate();
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityTextFieldMasked(
          controller: _ufController,
          label: 'Paraná',
          placeholder: 'Tatooine',
          icon: Icon(Icons.house),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) _formEnterpriseSignupKey.currentState!.validate();
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityTextFieldMasked(
          controller: _ramoController,
          label: 'Ramo',
          placeholder: 'Jedi',
          icon: Icon(Icons.edit_road),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) _formEnterpriseSignupKey.currentState!.validate();
          },
        ),
        SizedBox(
          height: 20,
        ),
        FidelityButton(label: 'Salvar', onPressed: () => _saveEnterpriseProfile(context)),
        FidelityTextButton(label: 'Voltar', onPressed: () => Get.back()),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  void _saveEnterpriseProfile(BuildContext context) async {
    final FormState? form = _formEnterpriseSignupKey.currentState;
    if (form!.validate()) {
      String _imageController = '';
      if (enterpriseController.selectedImage.length > 0) {
        List<int> imageBytes = enterpriseController.selectedImage;
        _imageController = base64Encode(imageBytes);
      }
      enterpriseController.profileEnterprise.value.name = _nameController.text;
      enterpriseController.profileEnterprise.value.cnpj = _nameController.text;
      enterpriseController.profileEnterprise.value.tel = _nameController.text;
      enterpriseController.profileEnterprise.value.adress = _nameController.text;
      enterpriseController.profileEnterprise.value.adressNum = _nameController.text;
      enterpriseController.profileEnterprise.value.city = _nameController.text;
      enterpriseController.profileEnterprise.value.state = _nameController.text;
      enterpriseController.profileEnterprise.value.branch = _nameController.text;

      enterpriseController.profileEnterprise.value.image = _imageController.isNotEmpty ? _imageController : null;
      await enterpriseController
          .changeProfile()
          .whenComplete(() => Get.toNamed('/settings/enterprise_profile/success'));
    }
  }
}
