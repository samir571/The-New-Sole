import 'package:get/get.dart';
import 'package:gypsy/model/product.dart';
import 'package:gypsy/screen/cart/extensions.dart';

import 'package:gypsy/screen/home/product_model.dart';

class HomeController extends GetxController {
  var productList = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;
  RxList<ProductModel> cartProducts = <ProductModel>[].obs;
  RxInt totalPrice = 0.obs;

  var isLoading = true.obs;
  var tabIndex = 0;
  RxInt productImageDefaultIndex = 0.obs;
  @override
  void onInit() {
    fetchProducts();
    getlikedItems();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      // isLoading(true);
      // var products = await RemoteServices.fetchProducts();

      // productList.value = products;
      // filteredProducts.assignAll(productList);
    } finally {
      isLoading(false);
    }
  }

  void addToCart(Product product) {
    // TODO #1: This is remain here:
    // product.quantity++;
    // cartProducts.add(product);
    cartProducts.assignAll(cartProducts.distinctBy((item) => item));
    calculateTotalPrice();
  }

  void decreaseItem(int index) {
    ProductModel product = cartProducts[index];
    if (product.quantity > 0) {
      product.quantity = product.quantity - 1;
    }
    calculateTotalPrice();
    // cartProducts.refresh();
    update();
  }

  bool isPriceOff(ProductModel product) {
    if (product.off != null) {
      return true;
    } else {
      return false;
    }
  }

  bool get isZeroQuantity {
    return cartProducts.any(
      (element) {
        return element.pPrice.compareTo(0) == 0 ? true : false;
      },
    );
  }

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in cartProducts) {
      if (isPriceOff(element)) {
        totalPrice.value += element.quantity * element.off;
      } else {
        totalPrice.value += element.quantity * element.pPrice;
      }
    }
  }

  bool get isEmptyCart {
    if (cartProducts.isEmpty || isZeroQuantity) {
      return true;
    } else {
      return false;
    }
  }

  void increaseItem(int index) {
    ProductModel product = cartProducts[index];
    product.quantity++;
    calculateTotalPrice();
    // cartProducts.refresh();
    update();
  }

  void changeIndex(int index) {
    if (index == 0) {
      filteredProducts.assignAll(productList);
    }
    if (index == 1) {
      getlikedItems();
    }
    tabIndex = index;
    update();
  }

  void getlikedItems() {
    filteredProducts
        .assignAll(productList.where((item) => item.isFavorite.value));
  }

  void switchBetweenProductImages(int index) {
    productImageDefaultIndex.value = index;
  }
}
