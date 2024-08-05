import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gypsy/constraints/constraints.dart';
import 'package:gypsy/model/order.dart';
import 'package:gypsy/repository/order_repository.dart';
import 'package:gypsy/response/product_order_response.dart';
import 'package:gypsy/widget/mobile_notification.dart';

import '../../repository/remote_cart_repository.dart';

class CanceledOrder extends StatefulWidget {
  const CanceledOrder({key});
  static const String route = "/Canceled_Order";

  @override
  State<CanceledOrder> createState() => _CanceledOrderState();
}

class _CanceledOrderState extends State<CanceledOrder> {
  List<Order> cancelledOrderList = [];

  @override
  Widget build(BuildContext context) {
    return getCancelledOrder();
  }

  FutureBuilder<OrderResponse?> getCancelledOrder() {
    return FutureBuilder<OrderResponse?>(
        future: OrderRepository().getAllOrder("Cancelled"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            cancelledOrderList = snapshot.data!.data!;
            return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.all(5.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: ListView.builder(
                  itemCount: cancelledOrderList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        showCancelAlertDialog(
                            context, cancelledOrderList[index]);
                      },
                      child: Card(
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
                                                cancelledOrderList[index]
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
                                              cancelledOrderList[index]
                                                  .productId!
                                                  .productName,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 30),
                                            Container(
                                              width: 60,
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 255, 0, 0),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: const Center(
                                                child: Text(
                                                  "Cancelled",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
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
                                            "Qty: ${cancelledOrderList[index].orderedQty}",
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
                                            "Rs. ${cancelledOrderList[index].productId!.productPrice}",
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
                                                  cancelledOrderList[index]
                                                      .orderedQty!;
                                              final productId =
                                                  cancelledOrderList[index]
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

  void showCancelAlertDialog(BuildContext context, Order order) {
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
                    'Remove ${order.productId!.productName} from cancelled:',
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
                                      order.productId!.productImageUrlList[0]),
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
                                order.productId!.productName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.blueAccent,
                              width: 180.0,
                              height: 20.0,
                              child: Text(
                                "Qty: ${order.orderedQty}",
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
                                "Rs. ${order.productId!.productPrice}",
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
                            List<Order> cloneOrderList = cancelledOrderList;
                            final result =
                                await OrderRepository().deleteOrder(order.id!);
                            if (result == true) {
                              cancelledOrderList
                                  .removeAt(cloneOrderList.length - 1);
                              MobileNotification.showNotification(
                                  notificationTitle:
                                      "${order.productId!.productName} Removed",
                                  notificationMessage:
                                      "Product Removed From Cancelled Ordered List");
                              setState(() {
                                cancelledOrderList = cloneOrderList;
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
