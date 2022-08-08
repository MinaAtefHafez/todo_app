// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class TaskTile extends StatelessWidget {
  final TaskModel taskModel;
  TaskTile({required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: taskModel.color == 0
                ? Colors.deepPurple
                : taskModel.color == 1
                    ? Colors.deepOrange
                    : Colors.pink,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${taskModel.title}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${taskModel.startTime}  -  ${taskModel.endTime}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${taskModel.note}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: 0.5,
                color: Colors.grey.shade700,
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    taskModel.isCompleted == 0 ? 'TODO' : 'Completed',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      
    );
  }
}
