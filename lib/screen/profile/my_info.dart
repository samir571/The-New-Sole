import 'package:flutter/material.dart';
import 'package:gypsy/widget/inputfield.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class MyinfoScreen extends StatefulWidget {
  const MyinfoScreen({key});
  static String route = "/UpdateScreen";

  @override
  State<MyinfoScreen> createState() => _MyinfoScreenState();
}

class _MyinfoScreenState extends State<MyinfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFFC6011),
        title: const Text("My Info",
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
                              "assets/images/myinfo.json",
                              height: 170,
                              width: 170,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            child: Column(
                              children: [
                                const UserInputField(
                                  hintText: 'Name',
                                  prefixIcon: LineAwesomeIcons.user,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const UserInputField(
                                  hintText: 'Email',
                                  prefixIcon: LineAwesomeIcons.envelope,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const UserInputField(
                                  hintText: 'Phone Number',
                                  prefixIcon: LineAwesomeIcons.phone,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const UserInputField(
                                  hintText: 'Address',
                                  prefixIcon: LineAwesomeIcons.location_arrow,
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
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFFFC6011),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    child: const Text('Update Profile'),
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
}
