
import 'package:gypsy/model/product.dart';
import 'package:gypsy/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: "_id")
  String? id;
  User? userId;
  Product? productId;
  int? orderedQty;
  int? totalPrice;
  String? deliveryStatusMessage;
  String? deliveryDate;

  Order(
      {this.id,
      this.userId,
      this.productId,
      this.orderedQty,
      this.totalPrice,
      this.deliveryStatusMessage,
      this.deliveryDate});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
