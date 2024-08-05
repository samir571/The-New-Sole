import 'package:json_annotation/json_annotation.dart';

part 'product_category.g.dart';

@JsonSerializable()
class ProductCategory {
  @JsonKey(name: "_id")
  String? id;
  String categoryName;
  String categoryDescription;
  String categoryImageURL;
  String categoryStatus;

  ProductCategory(this.categoryName, this.categoryDescription,
      this.categoryImageURL, this.categoryStatus,
      {this.id});

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);
}
