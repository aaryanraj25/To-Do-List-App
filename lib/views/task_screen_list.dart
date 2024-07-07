import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import 'widgets/task_item.dart';
import 'task_detail_screen.dart';
import 'task_search_screen.dart';
import 'widgets/task_sorting_options.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Get.to(() => TaskSearchScreen());
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              Get.bottomSheet(TaskSortingOptions());
            },
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return TaskItem(task: task, index: index);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => TaskDetailScreen());
        },
      ),
    );
  }
}
