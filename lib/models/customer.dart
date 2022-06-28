class CustomerEntries {
  List<Customer>? customers;

  CustomerEntries();
}

class Customer {
  int? id;
  int? userId;
  String? cpf;
  String? name;
  String? photo;

  Customer({
    this.id,
    this.userId,
    this.cpf,
    this.name,
    this.photo,
  });

  Customer.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    userId = json['UserId'],
    cpf = json['Cpf'],
    name = json['Name'],
    photo = json['Photo'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'UserId': userId,
    'Cpf': cpf,
    'Name': name,
    'Photo': photo,
  };
}
