import 'package:flutter/material.dart';

class ProfilePassword extends StatefulWidget {
  const ProfilePassword({
    Key? key,
    this.hintText,
    this.controller,
    this.validator,
  }) : super(key: key);
  final String? hintText;
  final controller;
  final validator;
  @override
  State<ProfilePassword> createState() => _ProfilePasswordState();
}

class _ProfilePasswordState extends State<ProfilePassword> {
  bool isHidden = true;
  bool success = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: isHidden,
        validator: widget.validator,
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
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.black,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: isHidden
                    ? const Icon(
                        Icons.visibility_off,
                        size: 24,
                        color: Colors.black,
                      )
                    : const Icon(Icons.visibility,
                        size: 24, color: Colors.black),
                onPressed: togglePasswordVisibility,
                // color: Colors.black,
              ),
            ),
            border: InputBorder.none),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
