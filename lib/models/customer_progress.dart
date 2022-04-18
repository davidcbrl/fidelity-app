import 'package:fidelity/models/customer.dart';
import 'package:fidelity/models/fidelity.dart';

class CustomerProgress {
  int? id;
  int? customerId;
  Customer? customer;
  int? fidelityId;
  Fidelity? fidelity;
  double? score;
  bool? status;

  CustomerProgress({
    this.id,
    this.customerId,
    this.customer,
    this.fidelityId,
    this.fidelity,
    this.status,
    this.score,
  });

  CustomerProgress.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    customerId = json['ClientId'],
    customer = json['Client'] != null ? Customer.fromJson(json['Client']) : null,
    fidelityId = json['LoyaltId'],
    fidelity = json['Loyalt'] != null ? Fidelity.fromJson(json['Loyalt']) : null,
    score = json['Points'],
    status = json['Status'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'ClientId': customerId,
    'Client': customer,
    'LoyaltId': fidelityId,
    'Loyalt': fidelity,
    'Points': score,
    'Status': status,
  };
}
