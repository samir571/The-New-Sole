import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gypsy/constraints/api_url.dart';
import 'package:gypsy/constraints/http_services.dart';
import 'package:gypsy/model/product_category.dart';
import 'package:gypsy/response/product_category_response.dart';

class ProductCategoryAPI {
  Future<bool> addProductCategory(ProductCategory productCategory) async {
    bool isProductCategoryAdded = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response =
          await dio.post(productCategoryUrl, data: productCategory.toJson());
      // response.data
      final ProductCategoryResponse productCategoryResponseData =
          ProductCategoryResponse.fromJson(response.data);
      if (productCategoryResponseData.success == true) {
        isProductCategoryAdded = true;
        return isProductCategoryAdded;
      }
    } catch (exception) {
      print(exception);
    }
    return isProductCategoryAdded;
  }

  Future<ProductCategoryResponse?> getAllProductCategory() async {
    ProductCategoryResponse? productCategoryResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      Response response = await dio.get(productCategoryUrl,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      productCategoryResponse = ProductCategoryResponse.fromJson(response.data);
      if (productCategoryResponse.success == true) {
        return productCategoryResponse;
      } else {
        productCategoryResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return productCategoryResponse;
  }
}
