import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/splash_screen.dart';
import 'package:todolist/controllers/task_controller.dart';
import 'package:todolist/services/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  // Ensure that plugin services are initialized
  

  // Initialize NotificationService
  final NotificationService notificationService = NotificationService();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  // Register TaskController with GetX dependency injection
  Get.put(TaskController(notificationService: notificationService));

  runApp(MyApp());
}

 

class MyApp extends StatelessWidget {
  final NotificationService _notificationService = NotificationService();
  MyApp() {
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    await _notificationService.initNotification();
    await _notificationService.requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDoList App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
