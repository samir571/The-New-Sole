import 'package:gypsy/model/product_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: "_id")
  String productId;
  String productName;
  String productDescription;
  int productPrice;
  int productSold;
  int productQuantity;
  // ProductCategory productCategory;
  List productImageUrlList;
  String productOffer;
  String productStatus;

  Product({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productSold,
    required this.productQuantity,
    // required this.productCategory,
    required this.productImageUrlList,
    required this.productOffer,
    required this.productStatus,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
