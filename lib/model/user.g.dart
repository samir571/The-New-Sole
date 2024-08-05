// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['name'] as String?,
      json['phoneNumber'] as String?,
      json['email'] as String?,
      json['address'] as String?,
      json['password'] as String?,
      json['userImage'] as String?,
      wishlistProduct: (json['wishlistProduct'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: json['userId'] as int? ?? 0,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'address': instance.address,
      'password': instance.password,
      'userImage': instance.userImage,
      'wishlistProduct': instance.wishlistProduct,
    };
