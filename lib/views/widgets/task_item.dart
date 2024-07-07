import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/models/task_model.dart';
import 'package:todolist/views/task_detail_screen.dart';
import '../../controllers/task_controller.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          final TaskController taskController = Get.find<TaskController>();
          taskController.toggleTaskCompletion(task);
        },
      ),
      onTap: () {
        Get.to(() => TaskDetailScreen(task: task));
      },
    );
  }
}
