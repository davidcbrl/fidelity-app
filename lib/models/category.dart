class Category {
  int? id;
  String? name;
  int? enterpriseId;

  Category({
    this.id,
    this.name,
    this.enterpriseId,
  });

  Category.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    name = json['Name'],
    enterpriseId = json['EnterpriseId'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Name': name,
    'EnterpriseId': enterpriseId,
  };
}
