import 'package:fidelity/models/fidelity_type.dart';

class Fidelity {
  int? id;
  int? companyId;
  String? name;
  String? description;
  String? initDate;
  String? endDate;
  FidelityType? type;

  Fidelity({this.id, this.companyId, this.name, this.description, this.initDate, this.endDate, this.type});

  Fidelity.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        companyId = json['EnterpriseId'],
        name = json['Name'],
        initDate = json['InitDate'],
        endDate = json['EndDate'],
        type = json['Type'],
        description = json['Description'];

  Map<String, dynamic> toJson() => {
        'Id': id,
        'EnterpriseId': companyId,
        'Name': name,
        'InitDate': initDate,
        'EndDate': endDate,
        'Type': type,
        'Description': description,
      };
}
