import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/views/widgets/task_sorting_options.dart';
import '../controllers/task_controller.dart';
import 'widgets/task_item.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDoList'),
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
            return TaskItem(task: task);
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
