



// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class ColorWidget extends StatelessWidget {
   
   final Color color ;

   ColorWidget({ required this.color});

  @override
  Widget build(BuildContext context) {
       return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 5 ),
         child: CircleAvatar(
          backgroundColor: color,
          radius: 15 ,
         ),
       );
  }
}