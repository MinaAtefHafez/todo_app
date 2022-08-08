// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  const InputField(
      {required this.hintText,  this.controller, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50 ,
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.deepPurple,
        style: const TextStyle(color: Colors.deepPurple),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500 , fontSize: 14  ),
          suffixIcon: suffixIcon,
          fillColor: Colors.grey.shade200,
          filled: true,
          enabled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade500)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade500)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade500)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade500)),
        ),
      ),
    );
  }
}
