import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/views/task_screen_list.dart';
import 'controllers/task_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDoList App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TaskListScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(TaskController());
      }),
    );
  }
}
