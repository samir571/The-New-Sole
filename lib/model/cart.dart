import 'package:gypsy/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  @JsonKey(name: "_id")
  String? id;
  String? userId;
  Product? productId;
  int? quantity;

  Cart({this.id, this.userId, this.productId, this.quantity});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
