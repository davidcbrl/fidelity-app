import 'package:fidelity/models/fidelity_promotion.dart';
import 'package:fidelity/models/fidelity_type.dart';

class Fidelity {
  int? id;
  int? enterpriseId;
  String? name;
  String? description;
  String? startDate;
  String? endDate;
  bool? status;
  FidelityType? type;
  int? fidelityTypeId;
  int? promotionTypeId;
  int? productId;
  FidelityPromotion? promotion;
  double? quantity;
  double? couponValue;
  int? consumedProductId;
  List<dynamic>? products;
  List<int>? productList;

  Fidelity({
    this.id,
    this.enterpriseId,
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
    this.type,
    this.promotion,
    this.products,
    this.consumedProductId,
    this.fidelityTypeId,
    this.productId,
    this.promotionTypeId,
    this.quantity,
    this.couponValue,
    this.productList,
  });

  Fidelity.fromJson(Map<String, dynamic> json):
    id = json['Id'],
    enterpriseId = json['EnterpriseId'],
    name = json['Name'],
    description = json['Description'],
    startDate = json['StartDate'],
    endDate = json['EndDate'],
    status = json['Status'],
    type = json['Type'],
    promotion = json['Promotion'],
    quantity = json['Quantity'],
    couponValue = json['CouponValue'],
    consumedProductId = json['ConsumedProductId'],
    promotionTypeId = json['PromotionTypeId'],
    productId = json['ProductId'],
    fidelityTypeId = json['FidelityTypeId'],
    products = json['Products'];

  Map<String, dynamic> toJson() => {
    'Id': id,
    'EnterpriseId': enterpriseId,
    'Name': name,
    'Description': description,
    'StartDate': startDate,
    'EndDate': endDate,
    'Status': status,
    'Type': type,
    'Promotion': promotion,
    'ConsumedProductId': consumedProductId,
    'FidelityTypeId': fidelityTypeId,
    'PromotionTypeId': promotionTypeId,
    'ProductId': productId,
    'ProductList': productList,
    'Quantity': quantity,
    'CouponValue': couponValue,
  };
}
