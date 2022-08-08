// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  const MyButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.deepPurple  ,
          borderRadius: BorderRadius.circular(10) ,
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
          
        ),
      ),
    );
  }
}
