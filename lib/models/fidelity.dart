import 'package:fidelity/models/fidelity_promotion.dart';
import 'package:fidelity/models/fidelity_type.dart';

class Fidelity {
  int? id;
  int? companyId;
  String? name;
  String? description;
  String? initDate;
  String? endDate;
  FidelityType? type;
  FidelityPromotion? promotion;
  List<dynamic>? products;

  Fidelity({
    this.id, 
    this.companyId, 
    this.name, 
    this.description, 
    this.initDate, 
    this.endDate,
    this.type,
    this.promotion,
    this.products,
  });

  Fidelity.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    companyId = json['EnterpriseId'],
    name = json['Name'],
    description = json['Description'],
    initDate = json['InitDate'],
    endDate = json['EndDate'],
    type = json['Type'],
    promotion = json['Promotion'],
    products = json['Products'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'EnterpriseId': companyId,
    'Name': name,
    'Description': description,
    'InitDate': initDate,
    'EndDate': endDate,
    'Type': type,
    'Promotion': promotion,
    'Products': products,
  };
}
