import 'package:fidelity/models/customer.dart';

class User {
  final int? id;
  final int? companyId;
  final String? type;
  final String? name;
  final String? email;
  final String? password;
  final Customer? customer;

  User({
    this.id,
    this.companyId,
    this.type,
    this.name,
    this.email,
    this.password,
    this.customer,
  });

  User.fromJson(Map<String, dynamic> json):
    id = json['UserId'],
    companyId = json['Id'],
    type = json['Type'],
    name = json['Name'],
    email = json['Email'],
    password = json['Password'],
    customer = json['Client'];

  Map<String, dynamic> toJson() => {
    'UserId': id,
    'Id': companyId,
    'Type': type,
    'Name': name,
    'Email': email,
    'Password': password,
    'Client': customer,
  };
}