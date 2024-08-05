import 'package:flutter/material.dart';
import 'package:gypsy/screen/login/login_screen.dart';
import 'package:gypsy/screen/register/register_screen.dart';

import 'package:gypsy/screen/splash/splash/starter/starter_painter.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({Key? key}) : super(key: key);
  static const String route = "/login_register_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const StarterPainter(),
          // const SplashLogo(),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Discover the best products from GYPSY GEAR\n and buy it ',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: const Color(0XFFFC6011),
                        height: 1.6,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, LoginScreen.route);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFFFC6011),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RegisterScreen.route);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    side: const BorderSide(
                      color: Color(0XFFFC6011),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text('Create An Account',
                      style: TextStyle(
                        color: Color(0XFFFC6011),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
