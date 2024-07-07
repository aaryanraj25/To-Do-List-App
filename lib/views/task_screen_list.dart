import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import 'widgets/task_item.dart';
import 'task_detail_screen.dart';
import 'task_search_screen.dart';
import 'widgets/task_sorting_options.dart';
import 'package:todolist/models/task_model.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Ensure you have your logo in the assets folder
              height: 40,
            ),
            SizedBox(width: 10),
            Text('To Do List'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Color(0xFF13002E),
            onPressed: () {
              Get.to(() => TaskSearchScreen());
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            color: Color(0xFF13002E),
            onPressed: () {
              Get.bottomSheet(TaskSortingOptions());
            },
          ),
        ],
      ),
      body: Obx(() {
        final tasksByDate = taskController.tasks
          ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

        Map<String, List<Task>> groupedTasks = {};
        for (var task in tasksByDate) {
          final dateKey = task.dueDate.toLocal().toIso8601String().split('T')[0];
          if (!groupedTasks.containsKey(dateKey)) {
            groupedTasks[dateKey] = [];
          }
          groupedTasks[dateKey]!.add(task);
        }

        return Container(
          color: Colors.white, // Set the background color to white
          child: ListView.builder(
            itemCount: groupedTasks.keys.length,
            itemBuilder: (context, index) {
              final dateKey = groupedTasks.keys.elementAt(index);
              final tasks = groupedTasks[dateKey]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      dateKey,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...tasks.map((task) {
                    return TaskItem(task: task, index: taskController.tasks.indexOf(task));
                  }).toList(),
                ],
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF13002E), // Set background color to #13002E
        child: Icon(
          Icons.add,
          color: Colors.yellow, // Set the icon color to yellow
        ),
        onPressed: () {
          Get.to(() => TaskDetailScreen());
        },
      ),
    );
  }
}
