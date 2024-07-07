import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/task_controller.dart';

class TaskSortingOptions extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Sort by Priority'),
            onTap: () {
              taskController.sortByPriority();
              Get.back();
            },
          ),
          ListTile(
            title: Text('Sort by Due Date'),
            onTap: () {
              taskController.sortByDueDate();
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
