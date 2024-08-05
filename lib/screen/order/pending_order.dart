import 'package:flutter/material.dart';
import 'package:gypsy/repository/order_repository.dart';
import 'package:gypsy/response/product_order_response.dart';

class PendingOrder extends StatefulWidget {
  const PendingOrder({key});
  static const String route = "/Pending_Order";

  @override
  State<PendingOrder> createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  @override
  Widget build(BuildContext context) {
    return getPendingOrder();
  }

  FutureBuilder<OrderResponse?> getPendingOrder() {
    return FutureBuilder<OrderResponse?>(
        future: OrderRepository().getAllOrder("Pending"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final pendingOrderList = snapshot.data!.data;
            return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.all(5.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: ListView.builder(
                  itemCount: pendingOrderList!.length,
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
                                              pendingOrderList[index]
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
                                            pendingOrderList[index]
                                                .productId!
                                                .productName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 30),
                                          Container(
                                            width: 62,
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
                                          "Qty: ${pendingOrderList[index].orderedQty}",
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
                                          "Rs. ${pendingOrderList[index].productId!.productPrice}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.green),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 205,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            final result =
                                                await OrderRepository()
                                                    .updateOrder(
                                                        pendingOrderList[index]
                                                            .id!,
                                                        "Cancelled");
                                            if (result == true) {
                                              setState(() {
                                                pendingOrderList
                                                    .removeAt(index);
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 17, 0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          child: const Text('Cancel Order'),
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
}
