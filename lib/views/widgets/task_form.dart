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

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? '';
    _description = widget.task?.description ?? '';
    _priority = widget.task?.priority ?? 1;
    _dueDate = widget.task?.dueDate ?? DateTime.now();
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

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Task newTask = Task(
        id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch,
        title: _title,
        description: _description,
        priority: _priority,
        dueDate: _dueDate,
        isCompleted: widget.task?.isCompleted ?? false,
      );
      widget.onSave(newTask);
    }
  }
}
