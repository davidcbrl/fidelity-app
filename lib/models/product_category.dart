class ProductCategoryEntries {
  ProductCategoryEntries();

  List<ProductCategory>? categories;

  ProductCategoryEntries.fromJson(Map<String, dynamic> json) : categories = json['categories'];

  Map<String, dynamic> toJson() => {'categories': categories};
}

class ProductCategory {
  int? id;
  String? name;

  ProductCategory({
    this.id,
    this.name,
  });

  ProductCategory.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    name = json['Name'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Name': name,
  };
}
