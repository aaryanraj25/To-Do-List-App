import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/views/task_screen_list.dart';
import 'controllers/task_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TaskController()); // Initialize the controller here
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDoList App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TaskListScreen(),
    );
  }
}
