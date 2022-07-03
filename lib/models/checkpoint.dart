class Checkpoints {
  List<Checkpoint>? checkpoints;

  Checkpoints({
    this.checkpoints,
  });

  Checkpoints.fromJson(Map<String, dynamic> json):
    checkpoints = json['Checkpoints'];

  Map<String, dynamic> toJson() => {
    'Checkpoints': checkpoints,
  };
}

class Checkpoint {
  int? id;
  int? companyId;
  int? customerId;
  int? fidelityId;
  double? value;
  bool? completed;

  Checkpoint({
    this.id,
    this.companyId,
    this.customerId,
    this.fidelityId,
    this.value,
    this.completed,
  });

  Checkpoint.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    companyId = json['EnterpriseId'],
    customerId = json['ClientId'],
    fidelityId = json['LoyaltId'],
    value = json['Value'],
    completed = json['Status'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'EnterpriseId': companyId,
    'ClientId': customerId,
    'LoyaltId': fidelityId,
    'Value': value,
    'Status': completed,
  };
}
