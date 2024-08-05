import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gypsy/constraints/responsive.dart';
import 'package:gypsy/model/user.dart';
import 'package:gypsy/repository/user_repo.dart';
import 'package:gypsy/repository/user_repository.dart';
import 'package:gypsy/screen/dashbaord/dashboard_screen.dart';
import 'package:gypsy/widget/mobile_notification.dart';
import 'package:gypsy/widget/passwordField.dart';
import 'package:gypsy/widget/textField.dart';
import 'package:local_auth/local_auth.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({key});

  static const String route = "/login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//  final double spacing = 20;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'samir@gmail.com');
  final _passwordController = TextEditingController(text: '12345678');

  //-----------------------------------SHared prefrences-------------
  _setDataToSharedPre(String email, String password) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('my_username', email);
      await pref.setString('my_password', password);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Finger sensor

  bool authenticated = false;
  //FingerPrint setup
  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometric;

  List<BiometricType>? _availableBiometrics;
  String authorized = "Not authorized";

  Future<void> _checkBiometric() async {
    bool? canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType>? availableBiometric;

    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      _availableBiometrics = availableBiometric;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger to authenticate",
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() async {
      authorized =
          authenticated ? "Authorization Successful" : "Failed to authenticate";

      if (authenticated) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? val = pref.getString("token");
        // // ignore: use_build_context_synchronously
        // Navigator.pushReplacementNamed(context, HomePage.route);

        if (val != null) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).popAndPushNamed(DashboardScreen.route);
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: 'basic_channel',
              title: "Logged In",
              body: "You are now logged in to your account!",
            ),
          );
        } else if (val == null) {
          // ignore: use_build_context_synchronously
          return MotionToast.error(
            description: const Text(
                "Sorry No Token Found, Login Using your Credentials!"),
          ).show(context);
        }
      }
      print(authorized);
    });
  }

  // ------------------------- Login Function With Object Box(----------------------------------
  _loginUserWithObjectBox() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    User? user =
        await UserRepositoryImplementation().loginUser(email, password);
    if (user != null) {
      _showMessage(true);
      Future.delayed(const Duration(seconds: 2),
          (() => Navigator.of(context).popAndPushNamed(DashboardScreen.route)));
    } else {
      _showMessage(false);
    }
  }

  // ------------------------- Login Function With API(----------------------------------
  _loginUserWithAPI(String email, String password) async {
    final isNewUserLogin = await UserRepository().loginUser(email, password);
    // _showMessage(isNewUserLogin);

    if (isNewUserLogin == true) {
      MotionToast.success(
        description: const Text('Successfully Login'),
        onClose: () {
          Navigator.of(context).popAndPushNamed(DashboardScreen.route);
        },
      ).show(context);
      MobileNotification.showNotification(
          notificationTitle: "Login Success",
          notificationMessage: "Login Successfully");
    } else {
      MotionToast.error(description: const Text('Fail to Login')).show(context);
    }
  }

  // ------------------ Motion toast for success or fail -----------------------
  _showMessage(
    bool checkLogin,
  ) {
    checkLogin == true
        ? MotionToast.success(
            description: const Text('Successfully Login'),
            onClose: () {
              Navigator.of(context).popAndPushNamed(DashboardScreen.route);
            },
          ).show(context)
        : MotionToast.error(description: const Text('Fail to Login'))
            .show(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // print(" Current Screen Height: ${MediaQuery.of(context).size.height}");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login page"),
        centerTitle: true,
        backgroundColor: const Color(0XFFFC6011),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: getProportionateScreenHeight(75)),
                Center(
                  child: Text(
                    "WELCOME TO NEW SOLE",
                    style: TextStyle(
                      color: const Color(0XFFFC6011),
                      fontSize: getProportionateScreenHeight(30.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Center(
                  child: Text(
                    "Add your details to login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenHeight(18.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                InputField(
                  // key: const ValueKey("username"),
                  controller: _emailController,
                  hintText: 'Enter your email',
                  prefixIcon: Icons.mail,
                ),
                SizedBox(height: getProportionateScreenHeight(17)),
                PasswordField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                ),
                const SizedBox(height: 17),
                Text(
                  "Forget your password?",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: const Color(0XFFFC6011),
                      ),
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
//-----------------------------TO LOGIN WITH USING OBJECT BOX -----------------------------------

                      // _loginUserWithObjectBox();

//-----------------------------TO LOGIN WITH USING API-----------------------------------

                      _loginUserWithAPI(
                          _emailController.text, _passwordController.text);
                    }
                    // Navigator.pushReplacementNamed(context, '/');
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
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  "--Or login With--",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigator.pushNamed(context, FingerprintAuthScreen.route);
                    _authenticate();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF3b5998),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.all(16),
                  ),
                  icon: const Icon(Icons.fingerprint_outlined),
                  label: const Text('Login with Fingerprint'),
                ),
                const SizedBox(height: 20),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have account?"),
                      TextButton(
                        child: const Text('Sign up',
                            style: TextStyle(fontSize: 20)),
                        onPressed: () {
                          Future.delayed(const Duration(seconds: 0), () {
                            Navigator.pushReplacementNamed(
                                context, '/register_screen');
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
