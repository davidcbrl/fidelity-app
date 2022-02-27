class CustomerEntries {
  List<Customer>? customers;

  CustomerEntries();
}

class Customer {
  final int? id;
  final String? cpf;
  final String? name;
  final String? photo;

  Customer({
    this.id,
    this.cpf,
    this.name,
    this.photo,
  });

  Customer.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    cpf = json['Cpf'],
    name = json['Name'],
    photo = json['Photo'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Cpf': cpf,
    'Name': name,
    'Photo': photo,
  };
}
