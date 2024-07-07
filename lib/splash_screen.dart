import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/views/task_screen_list.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to the main screen after a delay
    Future.delayed(Duration(seconds: 3), () {
      Get.off(TaskListScreen());
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash_screen.png'), // Make sure to update this with your image path
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
