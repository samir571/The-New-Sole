import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField(
      {Key? key,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.validator})
      : super(key: key);
  final controller;
  final String? hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: widget.validator,
        // validator: (value) {
        //   if (value == null || value.isEmpty) return "Required";
        //   return null;
        // },
        controller: widget.controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            labelText: widget.hintText,
            prefixIcon: null == widget.prefixIcon
                ? null
                : Icon(widget.prefixIcon, color: Colors.black),
            border: InputBorder.none),
      ),
    );
  }
}
