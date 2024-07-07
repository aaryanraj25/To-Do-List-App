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
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: _title,
              decoration: InputDecoration(labelText: 'Title'),
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
            TextFormField(
              initialValue: _description,
              decoration: InputDecoration(labelText: 'Description'),
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
            PriorityDropdown(
              initialPriority: _priority,
              onChanged: (value) {
                setState(() {
                  _priority = value;
                });
              },
            ),
            ListTile(
              title: Text('Due Date'),
              subtitle: Text(DateFormat.yMd().format(_dueDate)),
              trailing: Icon(Icons.calendar_today),
              onTap: _pickDueDate,
            ),
            ListTile(
              title: Text('Reminder'),
              subtitle: _reminderDateTime != null
                  ? Text(DateFormat.yMd().add_jm().format(_reminderDateTime!))
                  : Text('No reminder set'),
              trailing: Icon(Icons.alarm),
              onTap: _pickReminderDateTime,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveForm,
              child: Text('Save'),
            ),
          ],
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
          _reminderDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
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