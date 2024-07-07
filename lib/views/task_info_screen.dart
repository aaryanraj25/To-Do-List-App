import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Info',
          style: TextStyle(
            color: Color(0xFF13002E),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF13002E)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/logo.png', // Ensure you have your logo in the assets folder
                height: 150,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'About',
              style: TextStyle(
                color: Color(0xFF13002E),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This app helps you manage your tasks efficiently with features like prioritization, reminders, and sorting.',
              style: TextStyle(color: Color(0xFF13002E), fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Notes:',
              style: TextStyle(
                color: Color(0xFF13002E),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. The dates on the main screen represent the date of task completion.',
              style: TextStyle(color: Color(0xFF13002E), fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '2. Task Borders:',
              style: TextStyle(color: Color(0xFF13002E), fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                '   - Green: Low Priority\n   - Yellow: Medium Priority\n   - Red: High Priority',
                style: TextStyle(color: Color(0xFF13002E), fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '3. To edit a task, simply click on the task in the list.',
              style: TextStyle(color: Color(0xFF13002E), fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
