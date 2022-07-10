class EnterpriseEntries {
  List<Enterprise>? enterprises;

  EnterpriseEntries();
}

class Enterprise {
  int? id;
  int? userId;
  String? cnpj;
  String? name;
  String? tel;
  String? address;
  String? addressNum;
  String? state;
  String? city;
  String? image;
  String? branch;
  int? membershipId;
  DateTime? alterDate;
  String? employeeName;

  Enterprise({
    this.cnpj,
    this.tel,
    this.address,
    this.addressNum,
    this.state,
    this.city,
    this.branch,
    this.image,
    this.membershipId,
    this.alterDate,
    this.id,
    this.userId,
    this.name,
    this.employeeName,
  });

  Enterprise.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        userId = json['UserId'],
        name = json['Name'],
        cnpj = json['Cnpj'],
        tel = json['Tel'],
        address = json['Address'],
        addressNum = json['AddressNum'],
        state = json['State'],
        city = json['City'],
        branch = json['Branch'],
        image = json['Image'],
        membershipId = json['MembershipId'],
        employeeName = json['EmployeeName'],
        alterDate = json['AlterDate'];

  Map<String, dynamic> toJson() => {
        'Id': id,
        'UserId': userId,
        'Name': name,
        'Cnpj': cnpj,
        'Tel': tel,
        'Address': address,
        'AddressNum': addressNum,
        'State': state,
        'City': city,
        'Branch': branch,
        'Image': image,
        'MembershipId': membershipId,
        'EmployeeName': employeeName,
        'AlterDate': alterDate
      };
}
