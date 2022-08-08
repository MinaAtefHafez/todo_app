// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task_model.dart';

class DBHelper {
  static Database? db;
  static String tableName = 'task';

  static Future<void> initDb() async {
    if (db == null) {
      try {
        String path = '${await getDatabasesPath()}task.db';
        db = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('CREATE TABLE $tableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title STRING, note TEXT, date STRING, '
              'startTime STRING, endTime STRING, '
              'remind INTEGER, repeat STRING, color INTEGER, '
              'isCompleted INTEGER)');
          print('Create DB Success');
        });
      } catch (e) {
        Get.snackbar(
          'DB Create Error',
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
  }

  static Future<int> insert(TaskModel taskModel) async {
    return await db!.insert(tableName, taskModel.toJson());
  }

  static Future<int> delete(TaskModel taskModel) async {
    return await db!
        .delete(tableName, where: ' id = ? ', whereArgs: [taskModel.id]);
  }

  static Future<int> update(TaskModel taskModel) async {
    return await db!.rawUpdate('''
             UPDATE task 
             SET isCompleted = ? 
             WHERE id = ?
    ''', [1, taskModel.id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await db!.query(tableName);
  }
}
