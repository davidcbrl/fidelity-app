class FidelityPromotion {
  int? id;
  String? name;
  String? description;

  FidelityPromotion({
    this.id,
    this.name,
    this.description,
  });

  FidelityPromotion.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    name = json['Name'],
    description = json['Description'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Name': name,
    'Description': description,
  };
}
