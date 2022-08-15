import 'package:fidelity/controllers/category_controller.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Nova categoria',
      ),
      body: CategoryPageBody(),
    );
  }
}

class CategoryPageBody extends StatefulWidget {
  @override
  State<CategoryPageBody> createState() => _CategoryPageBodyState();
}

class _CategoryPageBodyState extends State<CategoryPageBody> {
  CategoryController categoryController = Get.put(CategoryController());
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();

  @override
  void initState() {
    if (categoryController.category.value.id != null) {
      _nameController.text = categoryController.category.value.name ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => categoryController.loading.value
      ? FidelityLoading(
          loading: categoryController.loading.value,
          text: 'Salvando categoria...',
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
                label: 'Salvar',
                onPressed: () {
                  saveCategory(context);
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
          label: 'Nome da categoria',
          placeholder: 'Alimento/Bebida',
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
          height: 40,
        ),
      ],
    );
  }

  Future<void> saveCategory(BuildContext context) async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      categoryController.loading.value = true;
      categoryController.category.value.name = _nameController.text;
      await categoryController.saveCategory();
      if (categoryController.status.isSuccess) {
        categoryController.loading.value = false;
        Get.toNamed('/category/success');
        return;
      }
      categoryController.loading.value = false;
      _showErrorDialog(context);
    }
  }

  Future<dynamic> _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Categorias',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          categoryController.status.errorMessage ?? 'Erro ao salvar categoria',
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