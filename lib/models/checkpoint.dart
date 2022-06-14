class Checkpoint {
  int? customerId;
  int? fidelityId;
  double? value;
  bool? completed;

  Checkpoint({
    this.customerId,
    this.fidelityId,
    this.value,
    this.completed,
  });

  Checkpoint.fromJson(Map<String, dynamic> json):
    customerId = json['ClientId'],
    fidelityId = json['LoyaltId'],
    value = json['Value'],
    completed = json['Status'];

  Map<String, dynamic> toJson() => {
    'ClientId': customerId,
    'LoyaltId': fidelityId,
    'Value': value,
    'Status': completed,
  };
}
