// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gypsy/repository/user_repository.dart';
import 'package:gypsy/screen/login/login_screen.dart';
import 'package:gypsy/widget/change_password.dart';
import 'package:gypsy/widget/snackbar.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({key});
  static String route = "/UpdateScreen";

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFFC6011),
        title: const Text("Change Password",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            // width: 30 * 4,
                            // height: 40 * 3,
                            child: LottieBuilder.asset(
                              "assets/images/password.json",
                              height: 200,
                              width: 200,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                ProfilePassword(
                                  controller: _oldPasswordController,
                                  hintText: 'Old Password',
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Field must be filled';
                                    }
                                    if (value.trim().length < 8) {
                                      return 'Password must be at least 8 characters in length';
                                    }
                                    // Return null if the entered password is valid
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ProfilePassword(
                                  controller: _newPasswordController,
                                  hintText: 'New Password',
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Field must be filled';
                                    }
                                    if (value.trim().length < 8) {
                                      return 'Password must be at least 8 characters in length';
                                    }
                                    // Return null if the entered password is valid
                                    return null;
                                  },
                                  // prefixIcon: LineAwesomeIcons.envelope,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ProfilePassword(
                                  hintText: 'Confirm Password',
                                  controller: _confirmPasswordController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Field must be filled';
                                    }
                                    if (value.trim().length < 8) {
                                      return 'Password must be at least 8 characters in length';
                                    }
                                    if (value != _newPasswordController.text) {
                                      return 'Password does not match';
                                    }
                                    // Return null if the entered password is valid
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 250,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (_confirmPasswordController.text ==
                                            _newPasswordController.text) {
                                          final result = await UserRepository()
                                              .changePassword(
                                                  _oldPasswordController.text,
                                                  _newPasswordController.text);
                                          if (result) {
                                            // Success Login
                                            showSnackbar(
                                                context,
                                                "Password Changed Successfully!",
                                                Colors.green);
                                            // doLogout();
                                          } else {
                                            // Login Failed
                                            showSnackbar(
                                                context,
                                                "Invalid Old Password!",
                                                Colors.red);
                                          }
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFFFC6011),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    child: const Text('Change Password'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void doLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    showSnackbar(context, "Logout Successfully!", Colors.orange);
    pref.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }
}
