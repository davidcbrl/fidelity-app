import 'package:fidelity/models/product_category.dart';

class ProductEntries {
  List<Product>? products;

  ProductEntries();
}

class Product {
  int? id;
  String? name;
  String? photo;
  bool? active;
  ProductCategory? category;
  String? value;

  Product();

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['nome'],
        photo = json['photo'],
        value = json['value'],
        active = json['active'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'photo': photo,
        'value': value,
        'active': active,
      };
}
