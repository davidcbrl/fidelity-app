class Checkpoint {
  int? customerId;
  int? fidelityId;
  double? value;

  Checkpoint({
    this.customerId,
    this.fidelityId,
    this.value,
  });

  Checkpoint.fromJson(Map<String, dynamic> json):
    customerId = json['ClientId'],
    fidelityId = json['LoyaltId'],
    value = json['Value'];

  Map<String, dynamic> toJson() => {
    'ClientId': customerId,
    'LoyaltId': fidelityId,
    'Value': value,
  };
}
