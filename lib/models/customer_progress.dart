class CustomerProgress {
  int? id;
  int? customerId;
  int? fidelityId;
  double? score;
  bool? status;

  CustomerProgress({
    this.id,
    this.customerId,
    this.fidelityId,
    this.status,
    this.score,
  });

  CustomerProgress.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    customerId = json['ClientId'],
    fidelityId = json['LoyaltId'],
    score = json['Points'],
    status = json['Status'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'ClientId': customerId,
    'LoyaltId': fidelityId,
    'Points': score,
    'Status': status,
  };
}
