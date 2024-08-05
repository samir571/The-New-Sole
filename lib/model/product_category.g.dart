// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) =>
    ProductCategory(
      json['categoryName'] as String,
      json['categoryDescription'] as String,
      json['categoryImageURL'] as String,
      json['categoryStatus'] as String,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$ProductCategoryToJson(ProductCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'categoryName': instance.categoryName,
      'categoryDescription': instance.categoryDescription,
      'categoryImageURL': instance.categoryImageURL,
      'categoryStatus': instance.categoryStatus,
    };
