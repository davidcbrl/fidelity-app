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
  int? enterpriseId;
  int? customerId;
  int? fidelityId;
  double? value;
  bool? completed;

  Checkpoint({
    this.id,
    this.enterpriseId,
    this.customerId,
    this.fidelityId,
    this.value,
    this.completed,
  });

  Checkpoint.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    enterpriseId = json['EnterpriseId'],
    customerId = json['ClientId'],
    fidelityId = json['LoyaltId'],
    value = json['Value'],
    completed = json['Status'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'EnterpriseId': enterpriseId,
    'ClientId': customerId,
    'LoyaltId': fidelityId,
    'Value': value,
    'Status': completed,
  };
}
