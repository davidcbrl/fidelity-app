import 'dart:convert';
import 'dart:typed_data';

import 'package:fidelity/controllers/product_category_controller.dart';
import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/models/product_category.dart';
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
  ProductCategoryController productCategoryController = Get.put(ProductCategoryController());
  GlobalKey<FormState> _formProductAddKey = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _valueController = new TextEditingController();
  ProductCategory _categoryController = new ProductCategory();
  bool _activeController = true;
  ImagePicker _picker = ImagePicker();
  var _selectedImage;

  @override
  void initState() {
    if (productController.product.value.id != null) {
      _nameController.text = productController.product.value.name ?? '';
      _valueController.text = productController.product.value.value.toString();
      _categoryController = productController.product.value.category ?? new ProductCategory();
      _activeController = productController.product.value.status == '1';
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
                                categoriesBottomSheet(context);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FidelityImagePicker(
                              image: productController.selectedImage.length > 0
                                  ? Uint8List.fromList(productController.selectedImage)
                                  : null,
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

  Future<void> categoriesBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext context) {
        return Container(
          height: 250,
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
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => productCategoryController.loading.value
                            ? FidelityLoading(
                                loading: productCategoryController.loading.value,
                                text: 'Carregando categorias...',
                              )
                            : Column(
                                children: [
                                  if (productCategoryController.status.isSuccess) ...[
                                    ...productCategoryController.categoriesList.map(
                                      (ProductCategory category) => FidelitySelectItem(
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
                                  if (productCategoryController.status.isEmpty ||
                                      productCategoryController.status.isError) ...[
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
      productController.product.value.status = _activeController ? '1' : '0';
      productController.product.value.image = _imageController.isNotEmpty ? _imageController : null;
      Get.toNamed('/product/fidelities');
    }
  }
}
