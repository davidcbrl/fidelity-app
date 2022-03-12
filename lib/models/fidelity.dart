class Fidelity {
  int? id;
  int? companyId;
  String? name;
  String? description;
  String? initDate;
  String? endDate;

  Fidelity({
    this.id,
    this.companyId,
    this.name,
    this.description,
    this.initDate,
    this.endDate,
  });

  Fidelity.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        companyId = json['EnterpriseId'],
        name = json['Name'],
        initDate = json['InitDate'],
        endDate = json['EndDate'],
        description = json['Description'];

  Map<String, dynamic> toJson() => {
        'Id': id,
        'EnterpriseId': companyId,
        'Name': name,
        'InitDate': initDate,
        'EndDate': endDate,
        'Description': description,
      };
}
