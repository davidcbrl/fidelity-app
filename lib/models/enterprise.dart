class EnterpriseEntries {
  List<Enterprise>? enterprises;

  EnterpriseEntries();
}

class Enterprise {
  int? id;
  String? cnpj;
  String? name;
  String? tel;
  String? adress;
  String? adressNum;
  String? state;
  String? city;
  String? image;
  String? branch;
  int? membershipId;
  int? active;
  DateTime? alterDate;

  Enterprise({
    this.cnpj,
    this.tel,
    this.adress,
    this.adressNum,
    this.state,
    this.city,
    this.branch,
    this.image,
    this.membershipId,
    this.active,
    this.alterDate,
    this.id,
    this.name,
  });

  Enterprise.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        name = json['Name'],
        cnpj = json['Cnpj'],
        tel = json['Tel'],
        adress = json['Adress'],
        adressNum = json['AdressNum'],
        state = json['State'],
        city = json['City'],
        branch = json['Branch'],
        image = json['Image'],
        membershipId = json['MembershipId'],
        //active = json['Active'],
        alterDate = json['AlterDate'];

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'Cnpj': cnpj,
        'Tel': tel,
        'Address': adress,
        'AddressNum': adressNum,
        'State': state,
        'City': city,
        'Branch': branch,
        'Image': image,
        'MembershipId': membershipId,
        'Active': active,
        'AlterDate': alterDate
      };
}
