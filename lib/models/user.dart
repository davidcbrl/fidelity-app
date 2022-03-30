import 'package:fidelity/models/customer.dart';
import 'package:fidelity/models/enterprise.dart';

class User {
  int? id;
  int? companyId;
  String? type;
  String? name;
  String? email;
  String? password;
  Customer? customer;
  Enterprise? enterprise;

  User({
    this.id,
    this.companyId,
    this.type,
    this.name,
    this.email,
    this.password,
    this.customer,
    this.enterprise,
  });

  User.fromJson(Map<String, dynamic> json):
    id = json['UserId'],
    companyId = json['Id'],
    type = json['Type'],
    name = json['Name'],
    email = json['Email'],
    password = json['Password'],
    enterprise = json['Enterprise'],
    customer = json['Client'];

  Map<String, dynamic> toJson() => {
    'UserId': id,
    'Id': companyId,
    'Type': type,
    'Name': name,
    'Email': email,
    'Password': password,
    'Client': customer,
    'Enterprise': enterprise,
  };
}
