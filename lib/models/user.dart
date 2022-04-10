import 'package:fidelity/models/customer.dart';
import 'package:fidelity/models/employee.dart';
import 'package:fidelity/models/enterprise.dart';

class User {
  int? id;
  int? companyId;
  String? type;
  String? name;
  String? email;
  String? password;
  String? photo;
  bool? active;
  String? status;
  Customer? customer;
  Employee? employee;
  Enterprise? enterprise;

  User({
    this.id,
    this.companyId,
    this.type,
    this.name,
    this.email,
    this.password,
    this.photo,
    this.status,
    this.customer,
    this.employee,
    this.enterprise,
  });

  User.fromJson(Map<String, dynamic> json):
    id = json['UserId'],
    companyId = json['Id'],
    type = json['Type'],
    name = json['Name'],
    email = json['Email'],
    password = json['Password'],
    photo = json['Photo'],
    status = json['Status'],
    customer = json['Client'],
    employee = json['Employee'],
    enterprise = json['Enterprise'];

  Map<String, dynamic> toJson() => {
    'UserId': id,
    'Id': companyId,
    'Type': type,
    'Name': name,
    'Email': email,
    'Password': password,
    'Photo': photo,
    'Status': status,
    'Client': customer,
    'Employee': employee,
    'Enterprise': enterprise,
  };
}
