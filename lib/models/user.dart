import 'package:fidelity/models/customer.dart';
import 'package:fidelity/models/employee.dart';
import 'package:fidelity/models/enterprise.dart';

class User {
  int? id;
  int? enterpriseId;
  String? type;
  String? name;
  String? email;
  String? password;
  String? image;
  String? photo;
  bool? active;
  String? status;
  Customer? customer;
  Employee? employee;
  Enterprise? enterprise;

  User({
    this.id,
    this.enterpriseId,
    this.type,
    this.name,
    this.email,
    this.password,
    this.image,
    this.photo,
    this.active,
    this.status,
    this.customer,
    this.employee,
    this.enterprise,
  });

  User.fromJson(Map<String, dynamic> json):
    id = json['UserId'],
    enterpriseId = json['Id'],
    type = json['Type'],
    name = json['Name'],
    email = json['Email'],
    password = json['Password'],
    image = json['Image'],
    photo = json['Photo'],
    active = json['Active'] != null ? json['Active'] == '1' : null,
    status = json['Status'],
    customer = json['Client'] != null ? Customer.fromJson(json['Client']) : null,
    employee = json['Employee'] != null ? Employee.fromJson(json['Employee']) : null,
    enterprise = json['Enterprise'] != null ? Enterprise.fromJson(json['Enterprise']) : null;

  Map<String, dynamic> toJson() => {
    'UserId': id,
    'Id': enterpriseId,
    'Type': type,
    'Name': name,
    'Email': email,
    'Password': password,
    'Image': image,
    'Photo': photo,
    'Status': status,
    'Client': customer,
    'Employee': employee,
    'Enterprise': enterprise,
  };
}
