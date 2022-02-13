class ProductCategoryEntries {
  ProductCategoryEntries();

  List<ProductCategory>? categories;

  ProductCategoryEntries.fromJson(Map<String, dynamic> json) : categories = json['categories'];

  Map<String, dynamic> toJson() => {'categories': categories};
}

class ProductCategory {
  ProductCategory();

  int? id;
  String? name;
  String? description;

  ProductCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}
