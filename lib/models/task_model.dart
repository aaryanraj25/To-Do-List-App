class Task {
  int id;
  String title;
  String description;
  int priority; // 1: Low, 2: Medium, 3: High
  DateTime dueDate;
  DateTime? reminderDateTime;
  bool isCompleted;
  bool reminderSent; 

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    this.reminderDateTime,
    this.isCompleted = false,
    this.reminderSent = false,
  });

  // Method to convert Task to a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'dueDate': dueDate.toIso8601String(),
      'reminderDateTime': reminderDateTime?.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  // Method to create a Task from a Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      dueDate: DateTime.parse(map['dueDate']),
      reminderDateTime: map['reminderDateTime'] != null ? DateTime.parse(map['reminderDateTime']) : null,
      isCompleted: map['isCompleted'] == 1,
    );
  }

  void setReminderSent(bool value) {
    reminderSent = value;
  }
}

