import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/models/task_model.dart';
import '../controllers/task_controller.dart';
import 'widgets/task_form.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();
  final Task? task;
  final int? index;

  TaskDetailScreen({this.task, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: TaskForm(
        task: task,
        onSave: (newTask) {
          if (task == null) {
            taskController.addTask(newTask);
          } else if (index != null) {
            taskController.updateTask(index!, newTask);
          }
          Get.back();
        },
      ),
    );
  }
}
