class ProductEntries {
  List<Product>? products;

  ProductEntries();
}

class Product {
  int? id;
  int? companyId;
  String? name;
  double? value;
  String? category;
  String? photo;
  bool? active;
  String? status;

  Product({
    this.id,
    this.companyId,
    this.name,
    this.value,
    this.category,
    this.photo,
    this.active, 
    this.status, 
  });

  Product.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    companyId = json['EnterpriseId'],
    name = json['Name'],
    value = json['Value'],
    photo = json['Photo'],
    category = json['Category'],
    active = json['Active'],
    status = json['Status'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'EnterpriseId': companyId,
    'Name': name,
    'Value': value,
    'Category': category,
    'Photo': photo,
    'Active': active,
    'Status': status,
  };
}
