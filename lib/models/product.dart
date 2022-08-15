import 'package:fidelity/models/category.dart';

class Product {
  int? id;
  int? enterpriseId;
  String? name;
  double? value;
  Category? category;
  int? categoryId;
  String? image;
  bool? status;
  List<dynamic>? fidelities;
  List<dynamic>? fidelitiesIds;

  Product({
    this.id,
    this.enterpriseId,
    this.name,
    this.value,
    this.category,
    this.categoryId,
    this.image,
    this.status,
    this.fidelities,
    this.fidelitiesIds,
  });

  Product.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    enterpriseId = json['EnterpriseId'],
    name = json['Name'],
    value = json['Value'],
    image = json['Image'],
    category = json['Category'] != null ? Category.fromJson(json['Category']) : null,
    categoryId = json['CategoryId'],
    status = json['Status'],
    fidelities = json['Loyalts'],
    fidelitiesIds = json['LoyaltList'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'EnterpriseId': enterpriseId,
    'Name': name,
    'Value': value,
    'Category': category,
    'CategoryId': categoryId,
    'Image': image,
    'Status': status,
    'Loyalts': fidelities,
    'LoyaltList': fidelitiesIds,
  };
}
