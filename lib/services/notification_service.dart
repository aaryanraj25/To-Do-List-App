import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/services.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    tz.initializeTimeZones();

    // Check and request the SCHEDULE_EXACT_ALARM permission on Android 13+
    if (await _needsExactAlarmPermission()) {
      await _requestExactAlarmPermission();
    }
  }

  Future<void> scheduleNotification(int id, String title, String body, DateTime scheduledTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<bool> _needsExactAlarmPermission() async {
    final bool isAndroid13OrHigher = await _isAndroid13OrHigher();
    if (!isAndroid13OrHigher) {
      return false;
    }
    final result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .areNotificationsEnabled();
    return result == false; // Explicitly handle the null case
  }

  Future<void> _requestExactAlarmPermission() async {
    try {
      await MethodChannel('dexterous.com/flutter/local_notifications')
          .invokeMethod('requestExactAlarmPermission');
    } on PlatformException catch (e) {
      print("Failed to request exact alarm permission: ${e.message}");
    }
  }

  Future<bool> _isAndroid13OrHigher() async {
    final version = await MethodChannel('dexterous.com/flutter/local_notifications')
        .invokeMethod<int>('getPlatformVersion');
    return version != null && version >= 33;
  }
}
