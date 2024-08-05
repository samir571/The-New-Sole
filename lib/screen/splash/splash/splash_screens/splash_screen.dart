import 'package:flutter/material.dart';
import 'package:gypsy/constraints/api_url.dart';
import 'package:gypsy/screen/dashbaord/dashboard_screen.dart';
import 'package:gypsy/screen/login/login_screen.dart';
import 'package:gypsy/screen/splash/splash/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({key});
  static const String route = "/splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _getDataFromSharedPre() async {
    final pref = await SharedPreferences.getInstance();
    final receivedToken = pref.getString("token");
    tokenConstant = receivedToken;
    final isUninstall = pref.getBool("isUninstall") ?? true;
    if (receivedToken != "" && receivedToken != null) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
      });
    } else {
      isUninstall == true
          ? Future.delayed(const Duration(seconds: 3), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnbaordingScreen()));
            })
          : Future.delayed(const Duration(seconds: 3), () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            });
    }
  }

  @override
  void initState() {
    _getDataFromSharedPre();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text.rich(
              TextSpan(
                text: 'THE NEW ',
                style: TextStyle(
                  color: Color(0XFF4A4B4D),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                children: [
                  TextSpan(
                    text: 'SOLE',
                    style: TextStyle(color: Color(0XFFFC6011)),
                  )
                ],
              ),
            ),
            SizedBox(height: 25),
            Text(
              'SINCE 2018',
              style: TextStyle(
                color: Color(0XFF7C7D7E),
                letterSpacing: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
