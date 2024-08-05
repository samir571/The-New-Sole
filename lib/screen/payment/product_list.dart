import 'package:flutter/material.dart';
import 'package:gypsy/model/cart.dart';
import 'package:gypsy/repository/remote_cart_repository.dart';
import 'package:gypsy/response/product_cart_response.dart';

class OrderProduct extends StatefulWidget {
  const OrderProduct({key});

  @override
  State<OrderProduct> createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color.fromARGB(255, 255, 85, 0),
                  ),
                ),
                onTap: () => print("ok"),
              ),
            ),
          ),
          // product start
          Container(
              padding: EdgeInsets.only(bottom: 10), child: getOrderProduct()),
          // product end
        ],
      ),
    );
  }

  List<Cart> orderItem = [];

  FutureBuilder<CartResponse?> getOrderProduct() {
    return FutureBuilder<CartResponse?>(
        future: CartRepository().getAllCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            orderItem = snapshot.data!.data!;
            return Container(
              width: double.infinity,
              height: 110,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.all(5.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
              child: ListView.builder(
                  itemCount: orderItem.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: const Color.fromARGB(255, 243, 241, 241),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image(
                              width: 100.0,
                              height: 100.0,
                              image: NetworkImage(
                                orderItem[index]
                                    .productId!
                                    .productImageUrlList[0],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderItem[index].productId!.productName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Qty: ${orderItem[index].quantity!}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Rs. ${orderItem[index].productId!.productPrice}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 42, 163, 46)),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  void showMyDesign() {}
}
