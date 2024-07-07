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
        title: Text(
          'Search Tasks',
          style: TextStyle(
            color: Color(0xFF13002E),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF13002E)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding to search controller
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(color: Color(0xFF13002E)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF13002E)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF13002E)),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Color(0xFF13002E)),
                  onPressed: () {
                    taskController.searchTasks(searchController.text);
                  },
                ),
              ),
              cursorColor: Color(0xFF13002E),
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
