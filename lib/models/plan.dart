class Plan {
  int? id;
  String? name;
  String? description;
  double? value;

  Plan({
    this.id,
    this.name,
    this.description,
    this.value,
  });

  Plan.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    name = json['Name'],
    description = json['Description'],
    value = json['Value'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Name': name,
    'Description': description,
    'Value': value,
  };
}
