import 'package:gypsy/model/cart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  String? message;
  bool? success;
  List<Cart>? data;

  CartResponse({this.success, this.message, this.data});

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}
