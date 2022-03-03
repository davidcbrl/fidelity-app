import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/models/product.dart';
import 'package:fidelity/models/product_category.dart';
import 'package:fidelity/pages/products/product_fidelities_page.dart';
import 'package:fidelity/widgets/fidelity_appbar.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_image_picker.dart';
import 'package:fidelity/widgets/fidelity_loading.dart';
import 'package:fidelity/widgets/fidelity_page.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/cupertino.dart';
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
  GlobalKey<FormState> _formProductAddKey = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _valueController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();
  bool _activeController = true;
  ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

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
                                if (value == null || value.isEmpty) return 'Campo vazio';
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
                                if (value == null || value.isEmpty) return 'Campo vazio';
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) _formProductAddKey.currentState!.validate();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: FidelityTextFieldMasked(
                                controller: _categoryController,
                                label: "Categoria",
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    enableDrag: false,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 200,
                                        color: Theme.of(context).colorScheme.surface,
                                        child: SingleChildScrollView(
                                          physics: AlwaysScrollableScrollPhysics(),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
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
                                              Column(
                                                children: _fakeGetCategoryList()
                                                    .categories!
                                                    .map((e) => categoryByCategory(e))
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                readOnly: true,
                                placeholder: "Selecione",
                                icon: Icon(Icons.list_outlined),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Campo vazio';
                                },
                                onChanged: (value) {
                                  if (value.isNotEmpty) _formProductAddKey.currentState!.validate();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FidelityImagePicker(
                              image: _selectedImage,
                              label: 'Foto do produto',
                              emptyImagePath: 'assets/img/product.png',
                              onSelect: () async {
                                _selectedImage = await _picker.pickImage(source: ImageSource.gallery);
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
                                    }),
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

  Widget categoryByCategory(
    ProductCategory category,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        productController.currentAddProduct.value.categoryId = category.id;
        _categoryController.text = category.name ?? '';
        Get.back();
      },
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            category.name ?? '',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  ProductCategoryEntries _fakeGetCategoryList() {
    ProductCategoryEntries categories = new ProductCategoryEntries();
    categories.categories = new List.generate(20, (index) {
      ProductCategory category = new ProductCategory();
      category.name = "nome" + index.toString();
      category.id = index;
      return category;
    });

    return categories;
  }

  void _preSaveProduct(BuildContext context) async {
    final FormState? form = _formProductAddKey.currentState;
    if (form!.validate()) {
      productController.product.value = new Product(
        companyId: 2,
        name: _nameController.text,
        value: double.parse(_valueController.text),
        categoryId: 1,
        status: _activeController ? '1' : '0',
      );
      Get.to(() => ProductFidelitiesPage(), transition: Transition.cupertino);
    }
  }
}
