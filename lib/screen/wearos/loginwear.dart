import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:gypsy/repository/user_repository.dart';
import 'package:gypsy/screen/wearos/registerwear.dart';
import 'package:gypsy/screen/wearos/wearDashboard.dart';
import 'package:gypsy/screen/wearos/wear_notification.dart';
import 'package:gypsy/widget/snackbar.dart';
import 'package:wear/wear.dart';

//To run wear OS
void main() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey:
            'basic_channel', //shown when enabling permission in the setting
        channelName: 'basic_channel', //name shown in setting
        defaultColor:
            const Color(0xFF0077B6), //default color of the notification
        importance:
            NotificationImportance.High, //display notification on screen
        //channelShowBadge: true, // to show number of notification badge on app icon
        // locked: false,
        channelDescription: 'test',
      ),
    ],
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gypsy Gear',
      initialRoute: WearloginScreen.route,
      routes: {
// ------------------------- All routes used in wearos---------------------------------
        '/wearLoginScreen': (context) => const WearloginScreen(),
        '/wearRegisterScreen': (context) => const WearRegisterScreen(),
        '/WearDashboardscreen': (context) => const WearDashboard(),
      }));
}

class WearloginScreen extends StatefulWidget {
  const WearloginScreen({Key? key}) : super(key: key);
  static const String route = "/wearLoginScreen";

  @override
  State<WearloginScreen> createState() => _WearloginScreenState();
}

class _WearloginScreenState extends State<WearloginScreen> {
  final double spacing = 20;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'dipesh@gmail.com');
  final _passwordController = TextEditingController(text: '1234567890');

// ------------------------- Login Function With OBJECTBOX(----------------------------------
// ------------------------- Objectbox is not added in wearos(----------------------------------

// ------------------------- Login Function With API(----------------------------------
  _loginUserWithAPI(String email, String password) async {
    final isNewUserLogin = await UserRepository().loginUser(email, password);
    _showMessage(isNewUserLogin);
  }

// ------------------ Motion toast for success or fail -----------------------
  _showMessage(bool checkLogin) {
    if (checkLogin == true) {
      showSnackbar(context, "Success", Colors.green);
      WearNotification.showNotification(
          notificationTitle: "Login Success",
          notificationMessage: "Login Successfully");
      Navigator.pushNamed(context, WearDashboard.route);
    } else {
      showSnackbar(context, " Error", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(builder: (context, mode, child) {
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
                        text: 'LOGIN',
                        style: TextStyle(
                          color: Color(0XFFFC6011),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, WearDashboard.route);
                          _loginUserWithAPI(
                              _emailController.text, _passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFFFC6011),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(double.infinity, 27),
                          // padding: const EdgeInsets.all(16),
                        ),
                        child: const Text(
                          'Login',
                        ),
                      ),
                      Text.rich(TextSpan(
                          text: 'Don\'t have an Account?',
                          style: const TextStyle(fontSize: 8),
                          children: [
                            TextSpan(
                                text: ' Sign Up',
                                style: const TextStyle(
                                  color: Color(0XFFFC6011),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .pushNamed(WearRegisterScreen.route);
                                  })
                          ]))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
