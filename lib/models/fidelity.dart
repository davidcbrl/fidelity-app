class Fidelity {
  int? id;
  int? companyId;
  String? name;
  String? description;

  Fidelity({
    this.id,
    this.companyId,
    this.name,
    this.description,
  });

  Fidelity.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    companyId = json['EnterpriseId'],
    name = json['Name'],
    description = json['Description'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'EnterpriseId': companyId,
    'Name': name,
    'Description': description,
  };
}
