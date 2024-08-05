import 'package:flutter/material.dart';

class UserInputField extends StatefulWidget {
  const UserInputField(
      {Key? key,
      this.hintText,
      // this.icon = Icons.person,
      this.prefixIcon,
      this.validator,
      this.errorText,
      this.controller,
      this.readOnly = false})
      : super(key: key);
  final String? hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final String? errorText;
  final controller;
  final readOnly;

  @override
  State<UserInputField> createState() => _UserInputFieldState();
}

class _UserInputFieldState extends State<UserInputField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        readOnly: widget.readOnly,
        cursorColor: Colors.black12,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                fontFamily: 'OpenSans', color: Color.fromARGB(255, 83, 76, 76)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0), width: 2),
                borderRadius: BorderRadius.circular(20)),
            filled: true,
            fillColor: const Color.fromARGB(255, 233, 214, 195),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0XFFFC6011), width: 2),
                borderRadius: BorderRadius.circular(25)),
            errorText: widget.validator != null ? null : widget.errorText,
            errorStyle: const TextStyle(fontSize: 15),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 207, 44, 32)),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(20)),
            prefixIcon: null == widget.prefixIcon
                ? null
                : const Padding(
                    padding: EdgeInsets.only(left: 8),
                  
                  ),
            border: InputBorder.none),
        style: const TextStyle(fontSize: 17, color: Colors.black54),
      ),
    );
  }
}
