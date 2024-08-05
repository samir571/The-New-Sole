import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:gypsy/style/style.dart';
import 'package:wear/wear.dart';

class WearDashboard extends StatefulWidget {
  const WearDashboard({key});
  static const String route = "/WearDashboardscreen";

  @override
  State<WearDashboard> createState() => _WearDashboardState();
}

class _WearDashboardState extends State<WearDashboard> {
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(builder: (context, mode, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                // itemCount: AppData.recommendedProducts.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Container(
                      height: 100,
                      width: 190,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  ' Welcome to the World \n of the Gypsy Gear !',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  ' Big Saving Upto \n 30% off',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    AwesomeNotifications().createNotification(
                                      content: NotificationContent(
                                        id: 1,
                                        channelKey: 'basic_channel',
                                        title: 'NOtification title',
                                        body: 'Balla aaipuge lastai jam thiyo',
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "Buy Now",
                                    style: TextStyle(
                                        fontSize: 8, color: mainColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // const Spacer(),
                          Image.asset(
                            'assets/images/shopping.png',
                            height: 75,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        );
      });
    });
  }
}
