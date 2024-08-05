// import 'dart:html';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:gypsy/helper/objectbox.dart';
import 'package:gypsy/sensor/shake_logout.dart';
import 'package:gypsy/state/objectbox_state.dart';

void main(List<String> args) async {
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

  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();
  runApp(const ShakeSensor());
}
