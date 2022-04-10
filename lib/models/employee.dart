class Employee {
  final int? id;

  Employee({
    this.id,
  });

  Employee.fromJson(Map<String, dynamic> json):
    id = json['Id'];

  Map<String, dynamic> toJson() => {
    'Id': id,
  };
}
