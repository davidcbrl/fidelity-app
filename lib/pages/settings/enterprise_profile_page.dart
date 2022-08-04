import 'dart:convert';
import 'dart:typed_data';

import 'package:fidelity/controllers/auth_controller.dart';
import 'package:fidelity/controllers/enterprise_controller.dart';
import 'package:fidelity/models/enterprise.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_image_picker.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
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
  TextEditingController _branchController = new TextEditingController();
  ImagePicker _picker = ImagePicker();
  AuthController authController = Get.find<AuthController>();
  var _selectedImage;

  final _formEnterpriseSignupKey = GlobalKey<FormState>();

  @override
  void initState() {
    _selectedImage =
        authController.user.value.image != null ? base64Decode(authController.user.value.image ?? '') : null;
    Get.find<AuthController>().user.value.type == "E" ? startEnterprise() : startCustomer();

    super.initState();
  }

  startCustomer() {
    _emailController.text = authController.user.value.email ?? "";
    _nameController.text = authController.user.value.customer?.name ?? "";
    _cnpjController.text = authController.user.value.customer?.cpf ?? "";
  }

  startEnterprise() {
    enterpriseController.profileEnterprise.value.enterprise = Enterprise();
    enterpriseController.getPlans();
    enterpriseController.plan.value = enterpriseController.plansList.elementAt(
        Get.find<AuthController>().user.value.enterprise!.membershipId! -
            (Get.find<AuthController>().user.value.enterprise!.membershipId! > 1 ? 2 : 1));
    _emailController.text = authController.user.value.email ?? "";
    _nameController.text = authController.user.value.enterprise?.name ?? "";
    _cnpjController.text = authController.user.value.enterprise?.cnpj ?? "";
    _contactController.text = authController.user.value.enterprise?.tel ?? "";
    _addressController.text = authController.user.value.enterprise?.address ?? "";
    _addressNumberController.text = authController.user.value.enterprise?.addressNum ?? "";
    _cityController.text = authController.user.value.enterprise?.city ?? "";
    _ufController.text = authController.user.value.enterprise?.state ?? "";
    _branchController.text = authController.user.value.enterprise?.branch ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => enterpriseController.loading.value
          ? FidelityLoading(
              loading: enterpriseController.loading.value,
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      child: _formFields(),
                      key: _formEnterpriseSignupKey,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _formFields() {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 25,
          ),
          FidelitySelectItem(
              label: enterpriseController.plan.value.name!,
              description: enterpriseController.plan.value.description!,
              onPressed: () {
                Get.toNamed('/signup/enterprise/third_step')?.whenComplete(() {
                  print("olar");
                });
              }),
          SizedBox(
            height: 10,
          ),
          FidelityImagePicker(
            size: 100,
            image: enterpriseController.selectedImage.length > 0
                ? Uint8List.fromList(enterpriseController.selectedImage)
                : _selectedImage,
            label: 'Toque para trocar a foto',
            emptyImagePath: 'assets/img/enterprise.png',
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
            readOnly: true,
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
            label: 'Estado',
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
            controller: _branchController,
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
      ),
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
      enterpriseController.profileEnterprise.value.enterprise?.name = _nameController.text;
      enterpriseController.profileEnterprise.value.enterprise?.cnpj = _cnpjController.text;
      enterpriseController.profileEnterprise.value.enterprise?.tel = _contactController.text;
      enterpriseController.profileEnterprise.value.enterprise?.address = _addressController.text;
      enterpriseController.profileEnterprise.value.enterprise?.addressNum = _addressNumberController.text;
      enterpriseController.profileEnterprise.value.enterprise?.city = _cityController.text;
      enterpriseController.profileEnterprise.value.enterprise?.state = _ufController.text;
      enterpriseController.profileEnterprise.value.enterprise?.branch = _branchController.text;
      enterpriseController.profileEnterprise.value.enterprise?.userId = authController.user.value.enterprise?.userId;
      enterpriseController.profileEnterprise.value.enterprise?.id = authController.user.value.enterprise?.id;
      enterpriseController.profileEnterprise.value.id = authController.user.value.id;
      enterpriseController.profileEnterprise.value.email = authController.user.value.email;
      enterpriseController.profileEnterprise.value.image = _imageController.isNotEmpty ? _imageController : null;
      await enterpriseController.changeProfile().whenComplete(() {
        if (enterpriseController.status.isSuccess) {
          authController.user.value.name = enterpriseController.profileEnterprise.value.enterprise!.name;
          authController.user.value.enterprise = enterpriseController.profileEnterprise.value.enterprise;
          Get.find<AuthController>().user.value.image = enterpriseController.profileEnterprise.value.image;
          Get.toNamed('/settings/enterprise_profile/success');
        }
      });
    }
  }
}
