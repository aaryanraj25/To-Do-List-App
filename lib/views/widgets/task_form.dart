import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/task_model.dart';
import 'priority_dropdown.dart';

class TaskForm extends StatefulWidget {
  final Task? task;
  final Function(Task) onSave;

  TaskForm({this.task, required this.onSave});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late int _priority;
  late DateTime _dueDate;
  DateTime? _reminderDateTime;

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? '';
    _description = widget.task?.description ?? '';
    _priority = widget.task?.priority ?? 1;
    _dueDate = widget.task?.dueDate ?? DateTime.now();
    _reminderDateTime = widget.task?.reminderDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: TextStyle(
            color: Color(0xFF13002E),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF13002E)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Color(0xFF13002E)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF13002E)),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF13002E)),
                  ),
                ),
                cursorColor: Color(0xFF13002E),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Color(0xFF13002E)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF13002E)),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF13002E)),
                  ),
                ),
                cursorColor: Color(0xFF13002E),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 16),
              PriorityDropdown(
                initialPriority: _priority,
                onChanged: (value) {
                  setState(() {
                    _priority = value;
                  });
                },
              ),
              ListTile(
                title: Text(
                  'Due Date',
                  style: TextStyle(color: Color(0xFF13002E)),
                ),
                subtitle: Text(
                  DateFormat.yMd().format(_dueDate),
                  style: TextStyle(color: Color(0xFF13002E)),
                ),
                trailing: Icon(Icons.calendar_today, color: Colors.yellow),
                onTap: _pickDueDate,
              ),
              ListTile(
                title: Text(
                  'Reminder',
                  style: TextStyle(color: Color(0xFF13002E)),
                ),
                subtitle: _reminderDateTime != null
                    ? Text(
                        DateFormat.yMd().add_jm().format(_reminderDateTime!),
                        style: TextStyle(color: Color(0xFF13002E)),
                      )
                    : Text('No reminder set', style: TextStyle(color: Color(0xFF13002E))),
                trailing: Icon(Icons.alarm, color: Colors.yellow),
                onTap: _pickReminderDateTime,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF13002E),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: _saveForm,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.yellow),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDueDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }

  void _pickReminderDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _reminderDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_reminderDateTime ?? DateTime.now()),
      );
      if (pickedTime != null) {
        setState(() {
          _reminderDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Task newTask = Task(
        id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch,
        title: _title,
        description: _description,
        priority: _priority,
        dueDate: _dueDate,
        reminderDateTime: _reminderDateTime,
        isCompleted: widget.task?.isCompleted ?? false,
      );
      widget.onSave(newTask);
    }
  }
}
