import 'package:fidelity/models/fidelity.dart';

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
  Fidelity? fidelity;
  double? value;
  double? score;
  double? originalScore;
  bool? completed;

  Checkpoint({
    this.id,
    this.enterpriseId,
    this.customerId,
    this.fidelityId,
    this.fidelity,
    this.value,
    this.score,
    this.originalScore,
    this.completed,
  });

  Checkpoint.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    enterpriseId = json['EnterpriseId'],
    customerId = json['ClientId'],
    fidelityId = json['LoyaltId'],
    fidelity = json['Loyalt'] != null ? Fidelity.fromJson(json['Loyalt']) : null,
    value = json['Value'],
    score = json['Points'],
    completed = json['Status'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'EnterpriseId': enterpriseId,
    'ClientId': customerId,
    'LoyaltId': fidelityId,
    'Loyalt': fidelity,
    'Value': value,
    'Points': score,
    'Status': completed,
  };
}
