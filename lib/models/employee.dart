class Employee {
  int? id;
  int? userId;
  String? name;
  int? enterpriseId;
  int? accessType;

  Employee({
    this.id,
    this.userId,
    this.name,
    this.enterpriseId,
    this.accessType,
  });

  Employee.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    userId = json['UserId'],
    name = json['Name'],
    enterpriseId = json['EnterpriseId'],
    accessType = json['AccessType'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'UserId': userId,
    'Name': name,
    'EnterpriseId': enterpriseId,
    'AccessType': accessType,
  };
}
