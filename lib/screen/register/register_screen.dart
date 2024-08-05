import 'package:flutter/material.dart';
import 'package:gypsy/model/user.dart';
import 'package:gypsy/repository/user_repository.dart';
import 'package:gypsy/screen/login/login_screen.dart';
import 'package:gypsy/widget/passwordField.dart';
import 'package:gypsy/widget/textField.dart';
import 'package:motion_toast/motion_toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({key});

  static const String route = "/register_screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userimageController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  // For Object Box
  // _registerUserWithOB() async {
  //   User user = User(
  //     _usernameController.text,
  //     _phoneNumberController.text,
  //     _emailController.text,
  //    __addressController.text,
  //     _passwordController.text,
  //     _userimageController.text,
  //   );
  //   int status = await UserRepositoryImplementation().addUser(user);
  //   _showMessage(status);
  // }

  _showMessage(int status) {
    if (status > 0) {
      MotionToast.success(description: const Text('Register successfully'))
          .show(context);
    } else {
      MotionToast.error(description: const Text('Register fail')).show(context);
    }
  }

  // For Using API
  _registerUserWithAPI(User user) async {
    final isNewUserLogin = await UserRepository().registerUser(user);
    _showMessageAPI(isNewUserLogin);
  }

  // ------------------ Motion toast for success or fail -----------------------
  _showMessageAPI(bool checkLogin) {
    checkLogin == true
        ? MotionToast.success(
            description: const Text('Successfully Sign Up'),
            onClose: () {
              Navigator.of(context).popAndPushNamed(LoginScreen.route);
            },
          ).show(context)
        : MotionToast.error(description: const Text('user already exists'))
            .show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up page"),
        centerTitle: true,
        backgroundColor: const Color(0XFFFC6011),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 60),
                const Center(
                  child: Text(
                    "WELCOME",
                    style: TextStyle(
                      color: Color(0XFFFC6011),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Center(
                  child: Text(
                    "Add your details to Signup",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                InputField(
                  key: const ValueKey("username"),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Required";
                    return null;
                  },
                  controller: _usernameController,
                  hintText: 'Enter your username',
                  prefixIcon: Icons.person,
                ),
                const SizedBox(height: 17),

                InputField(
                  key: const ValueKey("email"),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                            .hasMatch(value)) {
                      return "Required";
                    }
                    return null;
                  },
                  controller: _emailController,
                  hintText: 'Enter your email',
                  prefixIcon: Icons.mail,
                ),
                const SizedBox(height: 17),

                InputField(
                  key: const ValueKey("phoneNumber"),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Required";
                    return null;
                  },
                  controller: _phoneNumberController,
                  hintText: 'Enter your phone NO.',
                  prefixIcon: Icons.person,
                ),
                const SizedBox(height: 17),

                PasswordField(
                  key: const ValueKey("Password"),
                  controller: _passwordController,
                  hintText: 'Enter your password',
                ),
                const SizedBox(height: 17),
                PasswordField(
                  key: const ValueKey("Confirm Password"),
                  controller: _confirmPasswordController,
                  hintText: 'Confirm your password',
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  key: const ValueKey("registerBtn"),
                  onPressed: () {
                    // _loginUser();
                    if (_confirmPasswordController.text !=
                        _passwordController.text) {
                      MotionToast.error(
                          description:
                              const Text("Confirm password does not matched"));
                    }
                    if (_formKey.currentState!.validate()) {
                      if (_passwordController.text.toString() ==
                          _confirmPasswordController.text.toString()) {
                      } else {
                        MotionToast.error(
                                description:
                                    const Text('Password must be same'))
                            .show(context);
                      }
                    }

//-----------------------------TO REGISTER WITH USING API-----------------------------------------

                    final User user = User(
                        _usernameController.text,
                        _phoneNumberController.text,
                        _emailController.text,
                        _addressController.text,
                        _passwordController.text,
                        _userimageController.text);
                    _registerUserWithAPI(user);

//-----------------------------TO REGISTER WITH USING OBJECT BOX-----------------------------------

                    // _registerUserWithOB();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFFFC6011),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text(
                    'Signup',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Already have account?'),
                      TextButton(
                        child: const Text('Sign in',
                            style: TextStyle(fontSize: 20)),
                        onPressed: () {
                          Future.delayed(const Duration(seconds: 0), () {
                            Navigator.pushReplacementNamed(
                                context, '/login_screen');
                          });
                          //signup screen
                        },
                      )
                    ]),

                // const Expanded(child: SizedBox.shrink()),
                // Text.rich(TextSpan(
                //     text: 'Don\'t have an Account?',
                //     style: Theme.of(context).textTheme.bodyText2,
                //     children: [
                //       TextSpan(
                //           text: ' Sign Up',
                //           style: const TextStyle(
                //             color: Colors.black,
                //             fontWeight: FontWeight.bold,
                //           ),
                //           recognizer: TapGestureRecognizer()
                //             ..onTap = () {
                //               Navigator.pushReplacementNamed(
                //                   context, '/register');
                //             })
                //     ])),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
