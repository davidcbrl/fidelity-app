class User {
  final int? id;
  final int? companyId;
  final String? name;

  User({
    this.id,
    this.companyId,
    this.name,
  });

  User.fromJson(Map<String, dynamic> json):
    id = json['UserId'],
    companyId = json['Id'],
    name = json['Name'];

  Map<String, dynamic> toJson() => {
    'UserId': id,
    'Id': companyId,
    'Name': name,
  };
}