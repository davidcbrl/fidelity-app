class Employee {
  int? id;
  int? userId;
  String? name;
  int? companyId;
  int? accessType;

  Employee({
    this.id,
    this.userId,
    this.name,
    this.companyId,
    this.accessType,
  });

  Employee.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    userId = json['UserId'],
    name = json['Name'],
    companyId = json['EnterpriseId'],
    accessType = json['AccessType'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'UserId': userId,
    'Name': name,
    'EnterpriseId': companyId,
    'AccessType': accessType,
  };
}
