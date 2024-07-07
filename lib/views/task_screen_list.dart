import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/task_controller.dart';
import 'widgets/task_item.dart';
import 'task_detail_screen.dart';
import 'task_search_screen.dart';
import 'task_info_screen.dart'; // Import the info screen
import 'widgets/task_sorting_options.dart';
import 'package:todolist/models/task_model.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();

    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            
            Center(
              child: Image.asset(
                'assets/logo.png', // Ensure you have your logo in the assets folder
                height: 80,
                width: 160,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Color(0xFF13002E),
            onPressed: () {
              taskController.clearSearchResults(); // Clear search results before opening the search screen
              Get.to(() => TaskSearchScreen());
            },
          ),
        ],
        backgroundColor: Colors.white, // Set AppBar background color to white
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/logo.png', // Ensure you have your logo in the assets folder
                  height: 140, // Make the logo bigger
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.info, color: Color(0xFF13002E)),
                title: Text('Info', style: TextStyle(color: Color(0xFF13002E))),
                onTap: () {
                  Get.to(() => InfoScreen());
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white, // Set the background color to white
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tasks',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF13002E)),
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
          ),
          Expanded(
            child: Obx(() {
              final tasksByDate = taskController.tasks
                ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

              Map<String, List<Task>> groupedTasks = {};
              for (var task in tasksByDate) {
                final dateKey = DateFormat('dd MMMM yyyy').format(task.dueDate.toLocal());
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
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0), // Add padding to the left side
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
          ),
        ],
      ),
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
