class ProductEntries {
  List<Product>? products;

  ProductEntries();
}

class Product {
  int? id;
  String? name;
  String? photo;
  Product();

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['nome'],
        photo = json['photo'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': name,
        'photo': photo,
      };
}
