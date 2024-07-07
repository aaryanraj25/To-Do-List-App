import 'package:flutter/material.dart';

class PriorityDropdown extends StatelessWidget {
  final int initialPriority;
  final ValueChanged<int> onChanged;

  PriorityDropdown({
    required this.initialPriority,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: initialPriority,
      decoration: InputDecoration(labelText: 'Priority'),
      items: [
        DropdownMenuItem(value: 1, child: Text('Low')),
        DropdownMenuItem(value: 2, child: Text('Medium')),
        DropdownMenuItem(value: 3, child: Text('High')),
      ],
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
