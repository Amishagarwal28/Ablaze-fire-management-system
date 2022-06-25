import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObscure = true;
  bool? enabled = true;

// ignore: use_key_in_widget_constructors
  CustomTextField(
      {this.controller,
      this.data,
      this.hintText,
      this.isObscure,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: isObscure!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            // enabledBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(10),
            //     borderSide: BorderSide(width: 2, color: Colors.black87)),
            border: InputBorder.none,
            prefixIcon: Icon(
              data,
              color: Colors.black,
            ),
            focusColor: Colors.black,
            hintText: hintText),
      ),
    );
  }
}
