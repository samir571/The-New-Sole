import 'package:gypsy/model/product.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'user.g.dart';

@Entity()
@JsonSerializable()
class User {
  @Id(assignable: true)
  int userId;
  String? name;
  String? phoneNumber;
  String? email;
  String? address;
  String? password;
  String? userImage;
  List<Product>? wishlistProduct;

  User(this.name, this.phoneNumber, this.email, this.address, this.password,
      this.userImage,
      {this.wishlistProduct, this.userId = 0});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
