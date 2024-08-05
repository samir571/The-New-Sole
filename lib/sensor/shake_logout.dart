import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gypsy/app/route.dart';
import 'package:gypsy/app/theme_data.dart';
import 'package:gypsy/screen/splash/splash/splash_screens/splash_screen.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shake/shake.dart';

class ShakeSensor extends StatefulWidget {
  const ShakeSensor({key});

  @override
  State<ShakeSensor> createState() => _ShakeSensorState();
}

class _ShakeSensorState extends State<ShakeSensor> {
  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();

    detector = ShakeDetector.autoStart(onPhoneShake: () {
      // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0);
      // setState(() {});
    });
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        enabledDebugging: true,
        publicKey: "test_public_key_bcbec49746364b548f9cf8ab6f0e097d",
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.route,
            theme: getApplicationTheme(),
            routes: routes,
          );
        });
  }
}
