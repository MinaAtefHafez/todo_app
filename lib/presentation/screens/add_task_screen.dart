// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/widgets/button.dart';
import 'package:todo_app/presentation/widgets/color_widget.dart';
import 'package:todo_app/presentation/widgets/color_widget_selected.dart';
import 'package:todo_app/presentation/widgets/input_field.dart';

class AddTaskScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Add Task',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/person.jpeg')),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                InputField(
                    hintText: 'enter title here', controller: titleController),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Note',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                InputField(
                    hintText: 'enter note here', controller: noteController),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Date',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                GetBuilder<TaskController>(builder: (taskController) {
                  return InputField(
                    hintText: controller.selectedDate,
                    suffixIcon: IconButton(
                        onPressed: () {
                          getDateTime(context).then((value) {
                            taskController.selectedDate = value;
                            taskController.upD();
                          });
                        },
                        icon: Icon(Icons.calendar_today_outlined)),
                  );
                }),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'Start Time',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          GetBuilder<TaskController>(builder: (taskController) {
                            return InputField(
                              hintText: controller.startTime,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    getTime(context, true).then((value) {
                                      taskController.startTime = value;
                                      taskController.upD();
                                    });
                                  },
                                  icon: Icon(Icons.access_time_rounded)),
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'End Time',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          GetBuilder<TaskController>(builder: (taskController) {
                            return InputField(
                              hintText: controller.endTime,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    getTime(context, false).then((value) {
                                      taskController.endTime = value;
                                      taskController.upD();
                                    });
                                  },
                                  icon: Icon(Icons.access_time_rounded)),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Remind',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                InputField(
                  hintText: '${controller.selectedRemind} minutes early',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        dropdownColor: Colors.blue.shade800,
                        items: controller.remindList.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(
                              '$e',
                              style: TextStyle(color: Colors.grey.shade200),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedRemind = value!;
                          controller.upD();
                        },
                        icon: Icon(Icons.keyboard_arrow_down),
                        value: controller.selectedRemind,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Repeat',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                InputField(
                  hintText: controller.selectedRepeat,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.blue.shade800,
                        items: controller.repeatList.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(color: Colors.grey.shade200),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedRepeat = value!;
                          controller.upD();
                        },
                        icon: Icon(Icons.keyboard_arrow_down),
                        value: controller.selectedRepeat,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          'Color',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  controller.colorIndex = index;
                                  controller.upD();
                                },
                                child: controller.colorIndex == index
                                    ? ColorWidgetSelected(
                                        color: controller.colorList[index])
                                    : ColorWidget(
                                        color: controller.colorList[index]),
                              );
                            },
                            itemCount: controller.colorList.length,
                          ),
                        ),
                      ],
                    ),
                    MyButton(
                        label: 'Create Task',
                        onTap: () {
                          controller.addToDatabase(TaskModel(
                              title: titleController.text,
                              note: noteController.text,
                              isCompleted: 0,
                              date: controller.selectedDate,
                              startTime: controller.startTime,
                              endTime: controller.endTime,
                              color: controller.colorIndex,
                              remind: controller.selectedRemind,
                              repeat: controller.selectedRepeat)).then((value) {
                                Get.back();
                              });
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<String> getDateTime(context) async {
    var finalDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    return DateFormat().add_yMd().format(finalDate!).toString();
  }

  Future<String> getTime(context, bool isStartTime) async {
    var time = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );

    String formattedTime = time!.format(context);

    return formattedTime;
  }
}
