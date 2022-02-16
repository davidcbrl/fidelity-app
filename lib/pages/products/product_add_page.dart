import 'package:fidelity/controllers/product_controller.dart';
import 'package:fidelity/models/product_category.dart';
import 'package:fidelity/pages/products/product_fidelities_page.dart';
import 'package:fidelity/widgets/fidelity_button.dart';
import 'package:fidelity/widgets/fidelity_text_button.dart';
import 'package:fidelity/widgets/fidelity_text_field.dart';
import 'package:fidelity/widgets/fidelity_text_field_masked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/fidelity_appbar.dart';
import '../../widgets/fidelity_page.dart';

class ProductAddPage extends StatelessWidget {
  const ProductAddPage({Key? key}) : super(key: key);

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

class ProductAddBody extends StatelessWidget {
  ProductAddBody({Key? key}) : super(key: key);
  GlobalKey<FormState> _formProductAddKey = new GlobalKey<FormState>();
  ProductController controller = Get.find<ProductController>();
  TextEditingController categoryController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _valueController = new TextEditingController();
    TextEditingController _photoController = new TextEditingController();
    return Container(
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
                      label: "Nome",
                      placeholder: "Nome do produto",
                      icon: Icon(Icons.shopping_bag_outlined),
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
                      label: "Valor",
                      placeholder: "R\$",
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
                        controller: categoryController,
                        label: "Categoria",
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            enableDrag: false,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                color: Theme.of(context).colorScheme.background,
                                child: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text('Categorias'),
                                      Column(
                                        children:
                                            _fakeGetCategoryList().categories!.map((e) => categoryByCategory(e)).toList(),
                                      )
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
                    FidelityTextField(
                      controller: _photoController,
                      icon: Icon(Icons.image_outlined),
                      label: "Foto",
                      placeholder: "Toque para trocar a foto",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Switch(
                              value: controller.currentAddProduct.value.active ?? true,
                              onChanged: (value) {
                                value = !value;
                                controller.currentAddProduct.value.active = value;
                              }),
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
            label: "Proximo",
            onPressed: () {
              controller.setCurrentAddProduct(
                name: _nameController.text,
                photo: _photoController.text,
                value: _valueController.text
              );
              Get.to(() => ProductFidelitiesPage(), transition: Transition.rightToLeft);
            }
          ),
          FidelityTextButton(
            label: 'Voltar',
            onPressed: () {
              Get.back();
            }
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget categoryByCategory(
    ProductCategory category,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        controller.currentAddProduct.value.category = category;
        categoryController.text = category.name!;
        Get.back();
      },
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(category.name ?? ""),
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
}
