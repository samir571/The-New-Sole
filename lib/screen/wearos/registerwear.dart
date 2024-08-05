import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gypsy/screen/wearos/loginwear.dart';
import 'package:gypsy/style/style.dart';
import 'package:wear/wear.dart';

class WearRegisterScreen extends StatefulWidget {
  const WearRegisterScreen({Key? key}) : super(key: key);
  static const String route = "/wearRegisterScreen";

  @override
  State<WearRegisterScreen> createState() => _WearRegisterScreenState();
}

class _WearRegisterScreenState extends State<WearRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();
  final double spacing = 20;

  // _registerUser(User user) async {
  //   bool isLogin = await UserRepository().resgisterUser(user);
  //   if (isLogin) {
  //     _displayMessage(true);
  //   } else {
  //     _displayMessage(false);
  //   }
  // }

  // _displayMessage(bool isLogin) {
  //   if (isLogin) {
  //     Fluttertoast.showToast(
  //         msg: "You account is register",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Entry correct field ",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(height: 5),
                        const Text.rich(TextSpan(
                          text: 'REGISTER',
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 25,
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: const TextStyle(fontSize: 11),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 25,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email ',
                              labelStyle: const TextStyle(fontSize: 11),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 25,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(fontSize: 11),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 25,
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: const TextStyle(fontSize: 11),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 2),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // User user = User(
                              //   email: _emailController.text,
                              //   name: _nameController.text,
                              //   password: _passwordController.text,
                              //   cPassword: _confirmPasswordController.text,
                              // );
                              // _registerUser(user);
                            }
                            Navigator.pushReplacementNamed(
                                context, WearRegisterScreen.route);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(double.infinity, 23),
                            // padding: const EdgeInsets.all(16),
                          ),
                          child: const Text('Register'),
                        ),
                        Text.rich(TextSpan(
                            text: 'Already have an Account?',
                            style: const TextStyle(fontSize: 8),
                            children: [
                              TextSpan(
                                  text: ' Sign In',
                                  style: const TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, WearloginScreen.route);
                                    })
                            ]))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
