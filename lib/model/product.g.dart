// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['_id'] as String,
      productName: json['productName'] as String,
      productDescription: json['productDescription'] as String,
      productPrice: json['productPrice'] as int,
      productSold: json['productSold'] as int,
      productQuantity: json['productQuantity'] as int,
      productImageUrlList: json['productImageUrlList'] as List<dynamic>,
      productOffer: json['productOffer'] as String,
      productStatus: json['productStatus'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.productId,
      'productName': instance.productName,
      'productDescription': instance.productDescription,
      'productPrice': instance.productPrice,
      'productSold': instance.productSold,
      'productQuantity': instance.productQuantity,
      'productImageUrlList': instance.productImageUrlList,
      'productOffer': instance.productOffer,
      'productStatus': instance.productStatus,
    };
