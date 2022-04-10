import 'package:fidelity/models/fidelity_promotion.dart';
import 'package:fidelity/models/fidelity_type.dart';

class Fidelity {
  int? id;
  int? companyId;
  String? name;
  String? description;
  String? startDate;
  String? endDate;
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

  Fidelity(
      {this.id,
      this.companyId,
      this.name,
      this.description,
      this.startDate,
      this.endDate,
      this.type,
      this.promotion,
      this.products,
      this.consumedProductId,
      this.fidelityTypeId,
      this.productId,
      this.promotionTypeId,
      this.quantity,
      this.couponValue,
      this.productList});

  Fidelity.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        companyId = json['EnterpriseId'],
        name = json['Name'],
        description = json['Description'],
        startDate = json['StartDate'],
        endDate = json['EndDate'],
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
        'EnterpriseId': companyId,
        'Name': name,
        'Description': description,
        'StartDate': startDate,
        'EndDate': endDate,
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
