import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gypsy/constraints/api_url.dart';
import 'package:gypsy/constraints/http_services.dart';
import 'package:gypsy/response/product_cart_response.dart';

class CartAPI {
  Future<bool> addProductToCart(String productId, String quantity) async {
    bool isProductAddedToCart = false;
    Dio dio = HttpServices().getDioInstance();
    print("Api Called $cartUrl/insert/$productId/$quantity");
    try {
      // dio ko response
      Response response = await dio.post("$cartUrl/insert/$productId/$quantity",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final CartResponse cartResponseData =
          CartResponse.fromJson(response.data);
      if (cartResponseData.success == true) {
        print("cart result -->${cartResponseData.success}");
        isProductAddedToCart = true;
        return isProductAddedToCart;
      }
    } catch (exception) {
      print(exception);
    }
    return isProductAddedToCart;
  }

  Future<CartResponse?> getAllCart() async {
    CartResponse? cartResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$cartUrl/getCart",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      // response.data
      cartResponse = CartResponse.fromJson(response.data);
      if (cartResponse.success == true) {
        return cartResponse;
      } else {
        cartResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return cartResponse;
  }

  Future<bool> deleteProductFromCart(String productId) async {
    bool isCartDelete = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.delete("$cartUrl/delete/$productId",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final CartResponse cartResponseData =
          CartResponse.fromJson(response.data);
      if (response.data["success"] == true) {
        isCartDelete = true;
        return isCartDelete;
      }
    } catch (exception) {
      print(exception);
    }
    return isCartDelete;
  }
}
