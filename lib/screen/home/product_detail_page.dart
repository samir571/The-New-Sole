// import 'package:GuitarShop/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gypsy/model/product.dart';
import 'package:gypsy/repository/remote_cart_repository.dart';
import 'package:gypsy/screen/cart/cart_page.dart';
import 'package:gypsy/screen/home/home_controller.dart';
import 'package:gypsy/widget/mobile_notification.dart';
import 'package:gypsy/widget/show_toast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import '../../../core/app_color.dart';

final HomeController controller = Get.put(HomeController());

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isAvailable = false;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  int counter = 1;

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          controller.productImageDefaultIndex.value = 0;
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget productPageView(double width, double height) {
    return Container(
      height: height * 0.41,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFE5E6E8),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(210),
          bottomLeft: Radius.circular(210),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 270,
            width: 250,
            child: PageView.builder(
              // itemCount: product.images.length,
              itemCount: widget.product.productImageUrlList.length,
              controller: _pageController,
              onPageChanged: controller.switchBetweenProductImages,
              itemBuilder: (_, index) {
                return FittedBox(
                  fit: BoxFit.contain,
                  child: Image.network(
                    widget.product.productImageUrlList[index],
                    scale: 1,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => SmoothIndicator(
                effect: const WormEffect(
                    dotColor: Color.fromARGB(255, 160, 0, 0),
                    activeDotColor: Color(0xFFEC6813)),
                // ),
                offset: controller.productImageDefaultIndex.value.toDouble(),
                count: widget.product.productImageUrlList.length),
          )
        ],
      ),
    );
  }

  Widget _ratingBar(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
            initialRating: 4,
            // initialRating: widget.product.rating,
            direction: Axis.horizontal,
            itemBuilder: (_, index) {
              return const Icon(Icons.star, color: Color(0XFFFC6011));
            },
            onRatingUpdate: (rating) {}),
        const SizedBox(width: 30),
      ],
    );
  }

  bool getStatus(String productStatus) {
    if (productStatus == "available") {
      isAvailable = true;
    } else {
      isAvailable = false;
    }
    return isAvailable;
  }

  int qty = 1;
  bool isAddedToCart = false;

  addToCart(String productId, String quantity) async {
    final isNewItemAddedToCart =
        await CartRepository().addProductToCart(productId, quantity);
    return isNewItemAddedToCart;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productPageView(width, height),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.productName,
                      style: const TextStyle(
                        color: Color(0XFFFC6011),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _ratingBar(context),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          widget.product.productOffer != null
                              ? "Rs.${widget.product.productPrice}"
                              : "Rs.${widget.product.productPrice}",
                          //   style: const TextStyle(
                          style: const TextStyle(
                            color: Color(0XFFFC6011),
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Visibility(
                          visible: widget.product.productOffer != null
                              ? true
                              : false,
                          child: Text(
                            "Rs.${widget.product.productOffer}",
                            style: const TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 5,
                              color: Color.fromARGB(255, 72, 72, 72),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        // ignore: prefer_const_constructors
                        Text(
                          // product.isAvailable
                          //     ? "Available in stock"
                          //     : "Not available",
                          "Available in stock",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "About",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(widget.product.productDescription),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onLongPress: () {
                    //       setState(() {
                    //         counter++;
                    //       });
                    //     },
                    //     onPressed: getStatus(widget.product.productStatus)
                    //         ? () => controller.addToCart(widget.product)
                    //         : null,
                    //     style: ButtonStyle(
                    //       backgroundColor: MaterialStateProperty.all(
                    //           const Color.fromARGB(255, 236, 104, 19)),
                    //     ),
                    //     child: const Text(
                    //       "Add to cart",
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ),
                    // )
                    Container(
                      height: 115,
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 30, left: 20, right: 20),
                      decoration: const BoxDecoration(
                          color: Color(0XFFFC6011),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    qty > 1
                                        ? qty -= 1
                                        : ShowToast.showAlertDialog(
                                            context,
                                            "Quantity",
                                            "1 Items Must be selected");
                                  });
                                },
                                child: const Icon(
                                  Icons.remove,
                                  color: Color(0XFFFC6011),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("$qty"),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    qty += 1;
                                  });
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Color(0XFFFC6019),
                                ),
                              )
                            ]),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, left: 20, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.yellow),
                            child: GestureDetector(
                              onTap: () async {
                                final result = await addToCart(
                                    widget.product.productId, qty.toString());
                                setState(() {
                                  isAddedToCart = result != null ? true : false;
                                  MobileNotification.showNotification(
                                      notificationTitle:
                                          "${widget.product.productName} Added",
                                      notificationMessage:
                                          "Product Added To Cart");
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: const Text(
                                          "Item added to cart Successfully"),
                                      action: SnackBarAction(
                                          label: "View Cart",
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CartScreen()));
                                          })),
                                );
                              },
                              child: Text(
                                '${qty * widget.product.productPrice} | Add to cart',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
