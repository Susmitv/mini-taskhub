import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final VoidCallback onDelete;

  TaskTile({required this.title, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(task['title']),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => provider.deleteTask(task['id']),
        ),
      ),
    );
  }
}