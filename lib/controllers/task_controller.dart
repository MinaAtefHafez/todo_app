// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/screens/notification_screen.dart';

class TaskController extends GetxController {
  String selectedDate = DateFormat.yMd().format(DateTime.now()).toString();
  int selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weakly', 'Monthly'];
  List<Color> colorList = [Colors.deepPurple, Colors.deepOrange, Colors.pink];
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int colorIndex = 0;
  DateTime selectedTime = DateTime.now();

  List<TaskModel> taskList = [];
  
  

  @override
  void onInit() {
    super.onInit();
    getFromDatabase();
         
  }

   

  void upD() {
    update();
  }

   

  Future<void> addToDatabase(TaskModel taskModel) async {
    try {
      var result = await DBHelper.insert(taskModel);
      print(' result : $result');
      getFromDatabase();
      update();
    } catch (e) {
      Get.snackbar(
        'DB Insert Error',
        e.toString(),
        backgroundColor: Colors.red,
        borderRadius: 15,
        colorText: Colors.white,
        animationDuration: const Duration(seconds: 3),
        duration: const Duration(seconds: 3),
        padding: const EdgeInsets.all(15),
        dismissDirection: DismissDirection.down,
      );
      update();
    }
  }

  Future<void> getFromDatabase() async {
    try {
      var queryList = await DBHelper.query();
      taskList = queryList.map((e) => TaskModel.fromJson(e)).toList();
      update();
    } catch (e) {
      Get.snackbar(
        'DB Get Error',
        e.toString(),
        backgroundColor: Colors.red,
        borderRadius: 15,
        colorText: Colors.white,
        animationDuration: const Duration(seconds: 3),
        duration: const Duration(seconds: 3),
        padding: const EdgeInsets.all(15),
        dismissDirection: DismissDirection.down,
      );
      update();
    }
  }

  Future<void> updateDatabase(TaskModel model) async {
    try {
      await DBHelper.update(model);
      getFromDatabase();
      print('Updated SUCCESS');
      update();
    } catch (e) {
      Get.snackbar(
        'DB Update Error',
        e.toString(),
        backgroundColor: Colors.red,
        borderRadius: 15,
        colorText: Colors.white,
        animationDuration: const Duration(seconds: 3),
        duration: const Duration(seconds: 3),
        padding: const EdgeInsets.all(15),
        dismissDirection: DismissDirection.down,
      );
    }
  }

  Future<void> deleteFromDatabase(TaskModel model) async {
    try {
      await DBHelper.delete(model);
      getFromDatabase();
    } catch (e) {
      Get.snackbar(
        'DB Delete Error',
        e.toString(),
        backgroundColor: Colors.red,
        borderRadius: 15,
        colorText: Colors.white,
        animationDuration: const Duration(seconds: 3),
        duration: const Duration(seconds: 3),
        padding: const EdgeInsets.all(15),
        dismissDirection: DismissDirection.down,
      );
    }
  }

  void sendNotification(
      {required int id, required String body, required String title}) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: id,
      title: title,
      channelKey: 'todo app',
      body: body,
    ));

    AwesomeNotifications().actionStream.listen((event) {
      Get.to(() => NotificationScreen());
    });
  }
}
