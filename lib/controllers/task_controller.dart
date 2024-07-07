import 'package:get/get.dart';
import 'package:todolist/models/task_model.dart';
import 'package:todolist/repositories/task_repo.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  var searchResults = <Task>[].obs;
  final TaskRepository _taskRepository = TaskRepository();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    tasks.value = await _taskRepository.getTasks();
  }

  void addTask(Task task) async {
    await _taskRepository.addTask(task);
    fetchTasks();
  }

  void updateTask(int index, Task task) async {
    await _taskRepository.updateTask(task);
    fetchTasks();
  }

  void deleteTask(int index) async {
    await _taskRepository.deleteTask(tasks[index].id);
    fetchTasks();
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

  void searchTasks(String query) {
    searchResults.value = tasks.where((task) => task.title.contains(query)).toList();
  }
}
