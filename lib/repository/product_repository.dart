import 'dart:io';

import 'package:gypsy/data%20source/remote%20data%20source/product_api.dart';
import 'package:gypsy/model/product.dart';
import 'package:gypsy/response/product_response.dart';

class ProductRepository {
  Future<bool> addProduct(File? file, Product product) async {
    return await ProductAPI().addProduct(file, product);
  }
  Future<ProductResponse?> getAllProduct() async {
    return await ProductAPI().getAllProduct();
  }

  Future<ProductResponse?> getAllCategoryProduct(String categoryId) async {
    return await ProductAPI().getAllCategoryProduct(categoryId);
  }
}
