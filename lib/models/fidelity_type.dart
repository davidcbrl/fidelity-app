class FidelityType {
  int? id;
  String? name;
  String? description;

  FidelityType({
    this.id,
    this.name,
    this.description,
  });

  FidelityType.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        name = json['Name'],
        description = json['Description'];

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'Description': description,
      };
}
