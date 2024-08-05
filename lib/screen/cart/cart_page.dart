import 'package:flutter/material.dart';
import 'package:gypsy/model/cart.dart';
import 'package:gypsy/repository/remote_cart_repository.dart';
import 'package:gypsy/response/product_cart_response.dart';
import 'package:gypsy/screen/home/product_detail_page.dart';
import 'package:gypsy/screen/payment/payment.dart';
import 'package:gypsy/widget/mobile_notification.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({key});
  static String route = "/CartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> cartList = [];
  int? totalAmount = 0;
  List<Cart> cartListForTotalAmt = [];
  @override
  void initState() {
    setTotalCartAmt();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0XFFFC6011),
          title: const Text("My Cart",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, CartScreen.route);
                },
                child: LottieBuilder.asset(
                  "assets/images/carticon.json",
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ]),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Expanded(child: getAllCart()),
          const Divider(
            thickness: 4,
          ),
          SizedBox(
            width: double.infinity,
            height: 150,
            // color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total"),
                          Text("Rs. $totalAmount"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 380,
                    child: ElevatedButton(
                      onPressed: () {
                        Future.delayed(const Duration(seconds: 0), () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckoutPage()));
                        });

                        //signup screen
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0XFFFC6011),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text('Place Order'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<CartResponse?> getAllCart() {
    return FutureBuilder<CartResponse?>(
        future: CartRepository().getAllCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            cartList = snapshot.data!.data!;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(
                                    cartList[index].productId!)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        margin: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Row(
                          children: [
                            Container(
                              width: 100.0,
                              height: 90.0,
                              margin: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.grey[400],
                              ),
                              child: Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(cartList[index]
                                          .productId!
                                          .productImageUrlList[0]),
                                    ),
                                  )),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                SizedBox(
                                  width: 180.0,
                                  height: 30,
                                  // color: Colors.green,
                                  child: Text(
                                    cartList[index].productId!.productName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  // color: Colors.blueAccent,
                                  width: 180.0,
                                  height: 20.0,
                                  child: Text(
                                    "Qty: ${cartList[index].quantity}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  // color: Colors.blueAccent,
                                  width: 180.0,
                                  height: 20.0,
                                  child: Text(
                                    "Rs. ${cartList[index].productId!.productPrice * cartList[index].quantity!}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.green),
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              child: GestureDetector(
                                child:
                                    const Icon(Icons.delete, color: Colors.red),
                                onTap: () {
                                  showAlertDialog(context, cartList[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  void setTotalCartAmt() async {
    int? myTotalAmount = 0;
    final allCart = await CartRepository().getAllCart();
    cartListForTotalAmt = allCart!.data!;
    List<int> myAmountList = [];
    for (Cart i in cartListForTotalAmt) {
      int productAmount = i.productId!.productPrice * i.quantity!;
      myAmountList.add(productAmount);
    }
    for (int i in myAmountList) {
      myTotalAmount = myTotalAmount! + i;
    }
    setState(() {
      totalAmount = myTotalAmount;
    });
  }

  void showAlertDialog(BuildContext context, Cart cart) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Remove ${cart.productId!.productName} from cart:',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Row(
                      children: [
                        Container(
                          width: 100.0,
                          height: 90.0,
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.grey[400],
                          ),
                          child: Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      cart.productId!.productImageUrlList[0]),
                                ),
                              )),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            SizedBox(
                              width: 180.0,
                              height: 30,
                              // color: Colors.green,
                              child: Text(
                                cart.productId!.productName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.blueAccent,
                              width: 180.0,
                              height: 20.0,
                              child: Text(
                                "Qty: ${cart.quantity}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.blueAccent,
                              width: 180.0,
                              height: 20.0,
                              child: Text(
                                "Rs. ${cart.productId!.productPrice * cart.quantity!}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.green),
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          child: const Text('Remove'),
                          onPressed: () async {
                            List<Cart> cloneCartList = cartList;
                            final result = await CartRepository()
                                .deleteProductFromCart(
                                    cart.productId!.productId);
                            if (result == true) {
                              cartList.removeAt(cloneCartList.length - 1);
                              MobileNotification.showNotification(
                                  notificationTitle:
                                      "${cart.productId!.productName} Removed",
                                  notificationMessage:
                                      "Product Removed From Cart");
                              setState(() {
                                cartList = cloneCartList;
                                setTotalCartAmt();
                              });
                              Navigator.of(context).pop();
                            }
                          }),
                      ElevatedButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
