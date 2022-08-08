// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, sized_box_for_whitespace, curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/screens/add_task_screen.dart';
import 'package:todo_app/presentation/widgets/button.dart';
import 'package:todo_app/presentation/widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
   
   
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/person.jpeg')),
          ),
        ],
      ),
      body: Column(
        children: [
          addTaskBar(),
          addDateBar(),
          const SizedBox(
            height: 6,
          ),
          showTasks(context)
        ],
      ),
    );
  }

  Widget addTaskBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Today',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
          MyButton(
            label: '+ Add Task',
            onTap: () {
              Get.to(() => AddTaskScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget addDateBar() {
    return GetBuilder<TaskController>(builder: (taskController) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 85,
        child: DatePicker(
          DateTime.now(),
          daysCount: 30,
          selectionColor: Colors.amber,
          initialSelectedDate: DateTime.now(),
          onDateChange: (newDate) {
            taskController.selectedTime = newDate;
            taskController.upD();
          },
        ),
      );
    });
  }

  Widget noTaskMsg() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/task.svg',
            height: 150,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'you do not have any tasks yet ! \n Add new Tasks to make your days productive',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildBottomSheet({
    required String text,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        height: 50,
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.deepPurple.shade500),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<dynamic> showBottomSheet(TaskModel model) async {
    return Get.bottomSheet(
      GetBuilder<TaskController>(builder: (taskController) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              if (model.isCompleted == 0)
                buildBottomSheet(
                    text: 'Completed',
                    onTap: () {
                      taskController.updateDatabase(model).then((value) {
                        Get.back();
                      });
                    }),
              if (model.isCompleted == 0)
                SizedBox(
                  height: 12,
                ),
              buildBottomSheet(
                  text: 'Delete',
                  onTap: () {
                    taskController.deleteFromDatabase(model).then((value) {
                      Get.back();
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 1,
                  color: Colors.grey.shade400,
                ),
              ),
              buildBottomSheet(
                  text: 'Cancel',
                  onTap: () {
                    Get.back();
                  }),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      }),
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
    );
  }

  Widget showTasks(context) {
    return Expanded(
      child: GetBuilder<TaskController>(
        builder: (taskController) {
          if (taskController.taskList.isEmpty) {
            return noTaskMsg();
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await taskController.getFromDatabase();
              },
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    TaskModel task = taskController.taskList[index];
                    String dateBar = DateFormat.yMd()
                        .format(taskController.selectedTime)
                        .toString();

                    int dateDay = int.parse(task.date!.split('/')[1]);
                    int otherDay = int.parse(dateBar.split('/')[1]);

                    // ignore: unrelated_type_equality_checks
                    if (task.date == dateBar ||
                        task.repeat == 'Daily' ||
                        (task.repeat == 'Weakly' &&
                            (otherDay - dateDay) % 7 == 0)) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 1375),
                        child: SlideAnimation(
                          horizontalOffset: 300,
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () async {
                                await showBottomSheet(task);
                              },
                              child: TaskTile(
                                taskModel: task,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  itemCount: taskController.taskList.length),
            );
          }
        },
      ),
    );
  }
}
