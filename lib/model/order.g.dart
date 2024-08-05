// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String?,
      userId: json['userId'] == null
          ? null
          : User.fromJson(json['userId'] as Map<String, dynamic>),
      productId: json['productId'] == null
          ? null
          : Product.fromJson(json['productId'] as Map<String, dynamic>),
      orderedQty: json['orderedQty'] as int?,
      totalPrice: json['totalPrice'] as int?,
      deliveryStatusMessage: json['deliveryStatusMessage'] as String?,
      deliveryDate: json['deliveryDate'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'orderedQty': instance.orderedQty,
      'totalPrice': instance.totalPrice,
      'deliveryStatusMessage': instance.deliveryStatusMessage,
      'deliveryDate': instance.deliveryDate,
    };
