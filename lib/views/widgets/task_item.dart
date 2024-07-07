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

    Color getBorderColor() {
      switch (task.priority) {
        case 3:
          return Colors.red;
        case 2:
          return Colors.yellow;
        case 1:
        default:
          return Colors.green;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding for left and right sides
      child: Card(
        color: Colors.white, // Set the background color to white
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: getBorderColor(),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(task.description),
          trailing: Wrap(
            spacing: 12, // space between two icons
            children: <Widget>[
              Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  taskController.toggleTaskCompletion(task);
                },
                activeColor: Colors.green, // Set the checkbox color to green
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red, // Set the delete icon color to red
                onPressed: () {
                  taskController.deleteTask(index);
                },
              ),
            ],
          ),
          onTap: () {
            Get.to(() => TaskDetailScreen(task: task, index: index));
          },
        ),
      ),
    );
  }
}
