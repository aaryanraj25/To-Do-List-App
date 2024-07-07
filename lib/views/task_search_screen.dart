import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import 'widgets/task_item.dart';

class TaskSearchScreen extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Tasks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    taskController.searchTasks(searchController.text);
                  },
                ),
              ),
              onChanged: (value) {
                taskController.searchTasks(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              final results = taskController.searchResults;
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final task = results[index];
                  return TaskItem(task: task, index: taskController.tasks.indexOf(task));
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
