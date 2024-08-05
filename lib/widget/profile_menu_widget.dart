// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor = Colors.green,
    this.bgColor = Colors.black,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 20 * 2,
        height: 20 * 2,
        decoration: BoxDecoration(
            color: bgColor == bgColor.withOpacity(0.1)
                ? bgColor.withOpacity(0.1)
                : bgColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Icon(
          icon,
          color: iconColor == Colors.green ? Colors.green : iconColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      trailing: endIcon
          ? Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50 * 2)),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                color: Colors.grey,
                size: 20,
              ),
            )
          : null,
    );
  }
}
