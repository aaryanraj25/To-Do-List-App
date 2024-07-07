import 'package:get/get.dart';
import 'package:todolist/models/task_model.dart';
import 'package:todolist/repositories/task_repo.dart';
import 'package:todolist/services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'dart:async';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  var searchResults = <Task>[].obs;
  final TaskRepository _taskRepository = TaskRepository();
  final NotificationService _notificationService;
  Timer? _reminderTimer;

  // Constructor with NotificationService dependency
  TaskController({required NotificationService notificationService})
      : _notificationService = notificationService;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
    _notificationService.initNotification(); // Initialize NotificationService here
    tz.initializeTimeZones(); // Initialize timezone data
    startReminderCheck();
  }

  int generateTaskId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(1 << 31);
  }

  void fetchTasks() async {
    tasks.value = await _taskRepository.getTasks();
  }

  void addTask(Task task) async {
    task.id = generateTaskId(); // Assign an ID to the task
    await _taskRepository.addTask(task);
    tasks.add(task);

    // Schedule notification when adding a task
   

    update(); // Update the UI
  }

  void updateTask(int index, Task task) async {
    await _taskRepository.updateTask(task);
    tasks[index] = task;

    // Schedule notification when updating a task
    

    update();
  }

  void deleteTask(int index) async {
    await _taskRepository.deleteTask(tasks[index].id);
    tasks.removeAt(index);
    update();
  }

  

  void toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _taskRepository.updateTask(task);
    update();
  }

  void sortByPriority() {
    tasks.sort((a, b) => b.priority.compareTo(a.priority));
    update();
  }

  void sortByDueDate() {
    tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    update();
  }

  void sortByCreationDate() {
    tasks.sort((a, b) => a.id.compareTo(b.id));
    update();
  }

  void searchTasks(String query) {
    if (query.isEmpty) {
      searchResults.value = tasks;
    } else {
      searchResults.value = tasks.where((task) {
        return task.title.toLowerCase().contains(query.toLowerCase()) ||
            task.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void clearSearchResults() {
    searchResults.clear();
  }

  void startReminderCheck() {
  _reminderTimer = Timer.periodic(Duration(seconds: 1), (timer) {
    final now = DateTime.now();
    for (var task in tasks) {
      if (task.reminderDateTime != null && !task.isCompleted && !task.reminderSent) {
        final difference = task.reminderDateTime!.difference(now).inSeconds;
        if (difference <= 0) {
          _notificationService.showNotification(
            title: "To Do Reminder - Don't forget, ${task.title} awaits!",
            body: task.description,
          );
          task.setReminderSent(true); // Mark reminder as sent
        }
      }
    }
  });
}

  @override
  void onClose() {
    _reminderTimer?.cancel();
    super.onClose();
  }
}
