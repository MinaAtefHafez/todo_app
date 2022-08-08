// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/bindings/bindings.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      home: HomeScreen(),
    );
  }
}
