import 'package:flutter/material.dart';
import 'package:gypsy/screen/cart/cart_page.dart';
import 'package:gypsy/screen/dashbaord/dashboard_screen.dart';
import 'package:gypsy/screen/favorites/favorites_page.dart';
import 'package:gypsy/screen/login/login_screen.dart';
import 'package:gypsy/screen/map/my_store.dart';
import 'package:gypsy/screen/order/cancelled_order.dart';
import 'package:gypsy/screen/order/completed_order.dart';
import 'package:gypsy/screen/order/pending_order.dart';
import 'package:gypsy/screen/payment/payment.dart';
// import 'package:gypsy/screen/payment.dart';

import 'package:gypsy/screen/profile/about.dart';
import 'package:gypsy/screen/profile/change_password.dart';
import 'package:gypsy/screen/register/register_screen.dart';
import 'package:gypsy/screen/splash/splash/onboarding/onboarding.dart';
import 'package:gypsy/screen/splash/splash/splash_screens/splash_screen.dart';
import 'package:gypsy/screen/splash/splash/starter/starter_page.dart';

import '../screen/Order/order.dart';
import '../screen/home/home_page.dart';

var routes = <String, WidgetBuilder>{
  SplashScreen.route: (context) => const SplashScreen(),
  LoginRegisterScreen.route: (context) => const LoginRegisterScreen(),
  OnbaordingScreen.route: (context) => const OnbaordingScreen(),
  LoginScreen.route: (context) => const LoginScreen(),
  RegisterScreen.route: (context) => const RegisterScreen(),
  DashboardScreen.route: (context) => const DashboardScreen(),
  HomePage.route: (context) => const HomePage(),
  FavoriteScreen.route: (context) => const FavoriteScreen(),
  CartScreen.route: (context) => const CartScreen(),
  AboutScreen.route: (context) => AboutScreen(),
  ChangePasswordScreen.route: (context) => const ChangePasswordScreen(),

  // ConfirmationPage.route: (context) =>  ConfirmationPage(),
  CheckoutPage.route: (context) => CheckoutPage(),
  CanceledOrder.route: (context) => const CanceledOrder(),
  PendingOrder.route: (context) => const PendingOrder(),
  Completeorder.route: (context) => const Completeorder(),

  OrderScreen.route: (context) => const OrderScreen(),

   MyStoreLocation.route: (context) => const MyStoreLocation(),

  // ConfirmationPage.route: (context) => const ConfirmationPage(),
  // CheckoutPage.route: (context) => const CheckoutPage(),
  // ignore: equal_keys_in_map
  // OrderScreen.route: (context) =>  OrderScreen()

  // Test.route: (context) => const Test(),

  //wearOS route
  // WearloginScreen.route: (context) => const WearloginScreen(),
  // WearDashboard.route: (context) => const WearDashboard(),
  // WearRegisterScreen.route: (context) => const WearRegisterScreen(),
};
