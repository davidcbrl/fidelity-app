class User {
  final int? id;
  final String? name;

  User({
    this.id,
    this.name,
  });

  User.fromJson(Map<String, dynamic> json):
    id = json['id'],
    name = json['name'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}