import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gypsy/app/app.dart';
import 'package:gypsy/constraints/constraints.dart';
import 'package:gypsy/repository/order_repository.dart';
import 'package:gypsy/screen/dashbaord/dashboard_screen.dart';
import 'package:gypsy/screen/payment/product_list.dart';
import 'package:gypsy/screen/payment/shipping_address.dart';
import 'package:gypsy/screen/payment/total_amount.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

enum paymentEnum { COD, Khalti }

class CheckoutPage extends StatefulWidget {
  String? selectedPaymentMethod;
  CheckoutPage({Key? key}) : super(key: key);
  static const String route = "/Checkout";

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedIndex = 1;
  String getSelectedValue() {
    String paymentMethod = 'COD';
    if (selectedIndex == 1) {
      paymentMethod = "COD";
    } else if (selectedIndex == 2) {
      paymentMethod = "Khalti";
    } else if (selectedIndex == 3) {
      paymentMethod = "Esewa";
    }
    getSelectedPaymentMethod = paymentMethod;
    return paymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        backgroundColor: const Color(0XFFFC6011),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),

            const OrderProduct(),

            //
            const SizedBox(height: 7.0),

            //  Shipping and address
            const ShippingInfo(),
            //  Shipping and address end
            const SizedBox(height: 7.0),

            // Payment method
            Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.payment),
                      const Text('Cash on Delivery'),
                      Radio(
                        value: selectedIndex,
                        groupValue: 1,
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            selectedIndex = 1;
                            getSelectedValue();
                          });
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.payment),
                      const Text('Khalti Digital Wallet'),
                      Radio(
                        value: selectedIndex,
                        groupValue: 2,
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            selectedIndex = 2;
                            getSelectedValue();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Payment method end

            const SizedBox(height: 7.0),

            // payment
            const TotalScreen(),
            // const SizedBox(height: 30),
            const SizedBox(height: 15.0),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Future.delayed(const Duration(seconds: 0), () {
                    showAlertDialog(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const ConfirmationPage()));
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
                child: const Text('Confirm Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // icon:const Icon(Icons.question_mark),
        title: const Text('Confirm Order ?'),
        content: Text('Confirm payment with\n ${getSelectedPaymentMethod!}'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final result = await OrderRepository().addProductToOrder();
              if (result == true) {
                setPaymentMethod(getSelectedPaymentMethod!);
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Khalti
  khaltiWallet() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000,
          productIdentity: "1",
          productName: "nike blazers mid 77",
          mobile: "9808792437"),
      preferences: [PaymentPreference.khalti],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCanceled,
    );
  }

  // method to handle success
  void onSuccess(PaymentSuccessModel success) {
    showOrderDoneAlert();
  }

  showOrderDoneAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'Your order placed successfully',
      onConfirmBtnTap: () {
        showFlutterToast(
            "Default Payment Mode: $getSelectedPaymentMethod saved");
        selectedPaymentMethod = getSelectedPaymentMethod!;
        Navigator.of(context).pop();
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()));
      },
      // onCancelBtnTap: () {},
    );
  }

  void showFlutterToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green);
  }

  // method to handle failure
  void onFailure(PaymentFailureModel failure) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Failure"),
            content: const Text("Payment failed"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  // method to handle onCanceled
  void onCanceled() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Canceled"),
            content: const Text("Payment canceled"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  void setPaymentMethod(String selectedPaymentMethod) {
    print(selectedPaymentMethod);
    if (getSelectedPaymentMethod == "COD") {
      // Navigator.pushNamed(context, ConfirmationPage.route);
      showOrderDoneAlert();
    } else if (getSelectedPaymentMethod == "Khalti") {
      khaltiWallet();
    } else {
      print("From esewa");
    }
  }
}
