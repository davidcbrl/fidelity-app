import 'package:fidelity/models/product_category.dart';

class Product {
  int? id;
  int? companyId;
  String? name;
  double? value;
  ProductCategory? category;
  int? categoryId;
  String? image;
  bool? active;
  String? status;
  List<dynamic>? fidelities;
  List<dynamic>? fidelitiesIds;

  Product({
    this.id,
    this.companyId,
    this.name,
    this.value,
    this.category,
    this.categoryId,
    this.image,
    this.active,
    this.status,
    this.fidelities,
    this.fidelitiesIds,
  });

  Product.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    companyId = json['EnterpriseId'],
    name = json['Name'],
    value = json['Value'],
    image = json['Image'],
    category = json['Category'] != null ? ProductCategory.fromJson(json['Category']) : null,
    categoryId = json['CategoryId'],
    active = json['Active'],
    status = json['Status'],
    fidelities = json['Loyalts'],
    fidelitiesIds = json['LoyaltList'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'EnterpriseId': companyId,
    'Name': name,
    'Value': value,
    'Category': category,
    'CategoryId': categoryId,
    'Image': image,
    'Active': active,
    'Status': status,
    'Loyalts': fidelities,
    'LoyaltList': fidelitiesIds,
  };
}
