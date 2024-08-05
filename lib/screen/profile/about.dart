import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AboutScreen extends StatelessWidget {
  static const String route = "/aboutScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFFC6011),
        title: const Text("About Us",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              SizedBox(height: 30),
              Text(
                "GYPSY GEAR",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFFFC6011),
                ),

                //color: Color(0XFFFC6011),
              ),
              SizedBox(height: 35),
              Text(
                "Gypsy Gear is a mobile application that offers both online and offline services to simplify people's lives and make it more digital. With our platform, users can access both online services and physical store experiences in one convenient location. The goal of Gypsy Gear is to save time for our users and enhance their overall experience by providing a seamless transition between digital and in-person services.",
                style: TextStyle(fontSize: 15, color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
