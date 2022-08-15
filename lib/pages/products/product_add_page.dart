import 'dart:convert';
import 'dart:typed_data';

import 'package:fidelity/controllers/category_controller.dart';
import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/models/category.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_empty.dart';
import 'package:fidelity/widgets/fidelity_image_picker.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_option_item.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_select_item.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FidelityPage(
      appBar: FidelityAppbarWidget(
        title: 'Novo Produto',
      ),
      body: Container(height: Get.height, child: ProductAddBody()),
    );
  }
}

class ProductAddBody extends StatefulWidget {
  @override
  _ProductAddBodyState createState() => _ProductAddBodyState();
}

class _ProductAddBodyState extends State<ProductAddBody> {
  ProductController productController = Get.find<ProductController>();
  CategoryController categoryController = Get.put(CategoryController());
  GlobalKey<FormState> _formProductAddKey = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _valueController = new TextEditingController();
  Category _categoryController = new Category();
  bool _activeController = true;
  ImagePicker _picker = ImagePicker();
  var _selectedImage;

  @override
  void initState() {
    if (productController.product.value.id != null) {
      _nameController.text = productController.product.value.name ?? '';
      _valueController.text = productController.product.value.value.toString();
      _categoryController = productController.product.value.category ?? new Category();
      _activeController = productController.product.value.status ?? false;
      _selectedImage = productController.product.value.image != null
          ? base64Decode(productController.product.value.image ?? '')
          : null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => productController.loading.value
          ? FidelityLoading(
              loading: productController.loading.value,
              text: 'Salvando produto...',
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
                        key: _formProductAddKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FidelityTextFieldMasked(
                              controller: _nameController,
                              label: 'Nome',
                              placeholder: 'Nome do produto',
                              icon: Icon(Icons.label_important_outline),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo vazio';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) _formProductAddKey.currentState!.validate();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FidelityTextFieldMasked(
                              controller: _valueController,
                              label: 'Valor',
                              placeholder: 'R\$',
                              icon: Icon(Icons.attach_money_outlined),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo vazio';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) _formProductAddKey.currentState!.validate();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FidelityOptionItem(
                              label: 'Categoria',
                              selectedLabel: _categoryController.name,
                              onPressed: () {
                                _categoriesBottomSheet(context);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FidelityImagePicker(
                              image: productController.selectedImage.length > 0
                                  ? Uint8List.fromList(productController.selectedImage)
                                  : _selectedImage,
                              label: 'Foto do produto',
                              emptyImagePath: 'assets/img/product.png',
                              onSelect: () async {
                                XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
                                productController.selectedImage.value = await picked!.readAsBytes();
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
                                  "Produto ativo",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                            if (productController.product.value.fidelities != null) ...[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Fidelidades vinculadas",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FidelitySelectItem(
                                label: "${productController.product.value.fidelities!.length} Fidelidades",
                                description: "Clique aqui para editar",
                                onPressed: () {
                                  Get.toNamed('/product/fidelities');
                                },
                              ),
                            ],
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FidelityButton(
                    label: 'Próximo',
                    onPressed: () {
                      _preSaveProduct(context);
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

  Future<void> _categoriesBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext context) {
        return Container(
          height: Get.height - Get.height * 0.5,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Categorias',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => categoryController.loading.value
                            ? FidelityLoading(
                                loading: categoryController.loading.value,
                                text: 'Carregando categorias...',
                              )
                            : Column(
                                children: [
                                  if (categoryController.status.isSuccess) ...[
                                    ...categoryController.categoriesList.map(
                                      (Category category) => FidelitySelectItem(
                                        id: category.id,
                                        label: category.name ?? '',
                                        onPressed: () {
                                          productController.product.value.categoryId = category.id;
                                          setState(() {
                                            _categoryController = category;
                                          });
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  ],
                                  if (categoryController.status.isEmpty ||
                                      categoryController.status.isError) ...[
                                    FidelityEmpty(
                                      text: 'Nenhuma categoria encontrada',
                                      iconSize: 100,
                                    ),
                                  ],
                                ],
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _preSaveProduct(BuildContext context) async {
    final FormState? form = _formProductAddKey.currentState;
    if (form!.validate()) {
      String _imageController = '';
      if (productController.selectedImage.length > 0) {
        List<int> imageBytes = productController.selectedImage;
        _imageController = base64Encode(imageBytes);
      }
      productController.product.value.name = _nameController.text;
      productController.product.value.value = double.parse(_valueController.text);
      productController.product.value.categoryId = _categoryController.id ?? 1;
      productController.product.value.status = _activeController;
      productController.product.value.image = _imageController.isNotEmpty ? _imageController : null;

      if (productController.isCreatingFidelity.value) {
        await saveProduct(context);
        return;
      }
      Get.toNamed('/product/fidelities');
    }
  }

  Future<void> saveProduct(BuildContext context) async {
    productController.loading.value = true;
    await productController.saveProduct();
    if (productController.status.isSuccess) {
      productController.loading.value = false;
      Get.back();
      return;
    }
    productController.loading.value = false;
    _showErrorDialog(context);
  }

  Future<dynamic> _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Produtos',
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          productController.status.errorMessage ?? 'Erro ao salvar produto',
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
