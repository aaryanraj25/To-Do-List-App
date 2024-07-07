import 'package:get/get.dart';
import 'package:todolist/models/task_model.dart';
import 'package:todolist/repositories/task_repo.dart';
import '../services/notification_service.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  var searchResults = <Task>[].obs;
  final TaskRepository _taskRepository = TaskRepository();
  final NotificationService _notificationService = NotificationService();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
    _notificationService.init();
  }

  int generateTaskId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(1 << 31);
  }

  void fetchTasks() async {
    tasks.value = await _taskRepository.getTasks();
  }

  void addTask(Task task) async {
    await _taskRepository.addTask(task);
    if (task.reminderDateTime != null) {
      _notificationService.scheduleNotification(task.id, task.title, task.description, task.reminderDateTime!);
    }
    fetchTasks();
  }

  void updateTask(int index, Task task) async {
    await _taskRepository.updateTask(task);
    if (task.reminderDateTime != null) {
      _notificationService.scheduleNotification(task.id, task.title, task.description, task.reminderDateTime!);
    }
    fetchTasks();
  }

  void deleteTask(int index) async {
    await _taskRepository.deleteTask(tasks[index].id);
    _notificationService.cancelNotification(tasks[index].id);
    tasks.removeAt(index);
  }

  void toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _taskRepository.updateTask(task);
    fetchTasks();
  }

  void sortByPriority() {
    tasks.sort((a, b) => b.priority.compareTo(a.priority));
  }

  void sortByDueDate() {
    tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  void sortByCreationDate() {
    tasks.sort((a, b) => a.id.compareTo(b.id));
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
}
