import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gypsy/constraints/api_url.dart';
import 'package:gypsy/constraints/http_services.dart';
import 'package:gypsy/response/product_order_response.dart';

class OrderRemoteData {
  Future<bool> addProductToOrder() async {
    bool isProductAddedToOrder = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.post("$orderUrl/insert",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final OrderResponse orderResponseData =
          OrderResponse.fromJson(response.data);
      if (orderResponseData.success == true) {
        isProductAddedToOrder = true;
        return isProductAddedToOrder;
      }
    } catch (exception) {
      print(exception);
    }
    return isProductAddedToOrder;
  }

  Future<OrderResponse?> getAllOrder(String status) async {
    OrderResponse? orderResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$orderUrl/get/$status",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      // response.data
      orderResponse = OrderResponse.fromJson(response.data);
      if (orderResponse.success == true) {
        return orderResponse;
      } else {
        orderResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return orderResponse;
  }

  Future<bool> deleteOrder(String orderId) async {
    bool isOrderDelete = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.delete("$orderUrl/delete/$orderId",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final OrderResponse orderResponseData =
          OrderResponse.fromJson(response.data);
      if (orderResponseData.success == true) {
        isOrderDelete = true;
        return isOrderDelete;
      }
    } catch (exception) {
      print(exception);
    }
    return isOrderDelete;
  }

  Future<bool> updateOrder(String orderId, String status) async {
    bool isOrderDelete = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.put("$orderUrl/update/$orderId/$status",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final OrderResponse orderResponseData =
          OrderResponse.fromJson(response.data);
      if (orderResponseData.success == true) {
        isOrderDelete = true;
        return isOrderDelete;
      }
    } catch (exception) {
      print(exception);
    }
    return isOrderDelete;
  }

  Future<bool> cancelOrder(String orderId) async {
    bool isOrderCancelled = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.put("$orderUrl/update/$orderId/Cancelled",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final OrderResponse orderResponseData =
          OrderResponse.fromJson(response.data);
      if (orderResponseData.success == true) {
        isOrderCancelled = true;
        return isOrderCancelled;
      }
    } catch (exception) {
      print(exception);
    }
    return isOrderCancelled;
  }
}
