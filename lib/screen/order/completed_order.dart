import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gypsy/repository/order_repository.dart';
import 'package:gypsy/repository/remote_cart_repository.dart';
import 'package:gypsy/response/product_order_response.dart';

import '../../constraints/constraints.dart';

class Completeorder extends StatefulWidget {
  const Completeorder({key});
  static const String route = "/Complete_Order";

  @override
  State<Completeorder> createState() => _CompleteorderState();
}

class _CompleteorderState extends State<Completeorder> {
  @override
  Widget build(BuildContext context) {
    return getCompletedOrder();
  }

  FutureBuilder<OrderResponse?> getCompletedOrder() {
    return FutureBuilder<OrderResponse?>(
        future: OrderRepository().getAllOrder("Completed"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final completedOrderList = snapshot.data!.data;
            return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.all(5.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: ListView.builder(
                  itemCount: completedOrderList!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 241, 241),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  // margin: const EdgeInsets.all(4.0),
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
                                              completedOrderList[index]
                                                  .productId!
                                                  .productImageUrlList[0]),
                                        ),
                                      )),
                                ),
                                // const Spacer(),
                                const SizedBox(width: 7),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            completedOrderList[index]
                                                .productId!
                                                .productName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 50),
                                          Container(
                                            width: 40,
                                            margin:
                                                const EdgeInsets.only(top: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: const Center(
                                              child: Text(
                                                "Paid",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 180.0,
                                        // height: 30.0,
                                        child: Text(
                                          "Qty: ${completedOrderList[index].orderedQty}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 180.0,
                                        // height: 20.0,
                                        child: Text(
                                          "Rs. ${completedOrderList[index].productId!.productPrice}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.green),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            final orderQty =
                                                completedOrderList[index]
                                                    .orderedQty!;
                                            final productId =
                                                completedOrderList[index]
                                                    .productId!
                                                    .productId;

                                            await CartRepository()
                                                .addProductToCart(
                                                    productId, "$orderQty");
                                            showFlutterToast(
                                                "Ordered with $selectedPaymentMethod done");
                                            await OrderRepository()
                                                .addProductToOrder();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          child: const Text('Order Again'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  void showFlutterToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green);
  }
}
