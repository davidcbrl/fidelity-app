class Auth {
  final String? email;
  final String? password;

  Auth({
    this.email,
    this.password,
  });

  Auth.fromJson(Map<String, dynamic> json):
    email = json['email'],
    password = json['password'];

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}