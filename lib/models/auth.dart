class Auth {
  final String? email;
  final String? password;
  final String? type;

  Auth({
    this.email,
    this.password,
    this.type,
  });

  Auth.fromJson(Map<String, dynamic> json):
    email = json['email'],
    password = json['password'],
    type = json['type'];

  Map<String, dynamic> toJson() => {
    'email': email,
    'senha': password,
    // 'type': type,
  };
}