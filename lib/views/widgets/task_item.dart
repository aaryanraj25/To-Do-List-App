import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/models/task_model.dart';
import '../../controllers/task_controller.dart';
import '../task_detail_screen.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final int index;

  TaskItem({required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();

    return ListTile(
      title: Text(task.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.description),
          Text('Priority: ${task.priority}'),
          Text('Due: ${task.dueDate.toLocal()}'),
        ],
      ),
      trailing: Wrap(
        spacing: 12, // space between two icons
        children: <Widget>[
          Checkbox(
            value: task.isCompleted,
            onChanged: (value) {
              taskController.toggleTaskCompletion(task);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              taskController.deleteTask(index);
            },
          ),
        ],
      ),
      onTap: () {
        Get.to(() => TaskDetailScreen(task: task, index: index));
      },
    );
  }
}
