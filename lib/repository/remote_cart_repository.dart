import 'package:gypsy/data%20source/remote%20data%20source/cart_api.dart';
import 'package:gypsy/response/product_cart_response.dart';

class CartRepository {
  Future<bool> addProductToCart(String productId, String quantity) async {
    return await CartAPI().addProductToCart(productId, quantity);
  }

  Future<CartResponse?> getAllCart() async {
    return await CartAPI().getAllCart();
  }

  Future<bool?> deleteProductFromCart(String productId) async {
    return await CartAPI().deleteProductFromCart(productId);
  }
}
