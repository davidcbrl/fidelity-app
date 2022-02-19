class CustomerEntries {
  List<Customer>? customers;

  CustomerEntries();
}

class Customer {
  int? id;
  String? cpf;
  String? name;
  String? email;
  String? photo;
  String? password;

  Customer({
    this.id,
    this.cpf,
    this.name,
    this.email,
    this.photo,
    this.password,
  });

  Customer.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        cpf = json['Cpf'],
        name = json['Name'],
        photo = json['Photo'],
        email = json['Email'],
        password = json['Password'];

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Cpf': cpf,
        'Name': name,
        'Email': email,
        'Photo': photo,
        'Password': password,
      };
}
