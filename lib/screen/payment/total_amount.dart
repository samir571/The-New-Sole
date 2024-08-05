import 'package:flutter/material.dart';
import 'package:gypsy/model/cart.dart';
import 'package:gypsy/repository/remote_cart_repository.dart';

class TotalScreen extends StatefulWidget {
  const TotalScreen({key});

  @override
  State<TotalScreen> createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> {
  List<Cart> cartList = [];
  int? totalAmount = 0;
  List<Cart> cartListForTotalAmt = [];
  int? deliveryFee = 50;
  int? totalAmountWithDeliveryFee = 0;
  @override
  void initState() {
    setTotalCartAmt();
    setFinalAmount();
    super.initState();
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

  void setFinalAmount() async {
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
      totalAmountWithDeliveryFee = myTotalAmount! + deliveryFee!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 18),
              ),
              Text("$totalAmount", style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delivery Charge',
                style: TextStyle(fontSize: 18),
              ),
              Text('$deliveryFee', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
        const Divider(
          thickness: 1.5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sub Total',
                style: TextStyle(fontSize: 18),
              ),
              Text('$totalAmountWithDeliveryFee',
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ],
    ));
  }
}
