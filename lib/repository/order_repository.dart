import 'package:gypsy/data%20source/remote%20data%20source/order_api.dart';
import 'package:gypsy/response/product_order_response.dart';

class OrderRepository {
  Future<bool> addProductToOrder() async {
    return await OrderRemoteData().addProductToOrder();
  }

  Future<OrderResponse?> getAllOrder(String status) async {
    return await OrderRemoteData().getAllOrder(status);
  }

  Future<bool?> updateOrder(String orderId, String statusMessage) async {
    return await OrderRemoteData().updateOrder(orderId, statusMessage);
  }

  Future<bool?> deleteOrder(String orderId) async {
    return await OrderRemoteData().deleteOrder(orderId);
  }

  Future<bool?> cancelOrder(String orderId) async {
    return await OrderRemoteData().cancelOrder(orderId);
  }
}
