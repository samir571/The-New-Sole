import 'package:gypsy/data%20source/remote%20data%20source/product_category_api.dart';
import 'package:gypsy/model/product_category.dart';
import 'package:gypsy/response/product_category_response.dart';

class ProductCategoryRepository {
  Future<bool> addProductCategory(ProductCategory productCategory) async {
    return await ProductCategoryAPI().addProductCategory(productCategory);
  }

  Future<ProductCategoryResponse?> getAllProductCategory() async {
    return await ProductCategoryAPI().getAllProductCategory();
  }
}
