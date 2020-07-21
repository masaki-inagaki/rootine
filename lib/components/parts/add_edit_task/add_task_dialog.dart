import 'package:ROOTINE/components/parts/add_edit_task/add_task_form.dart';
import 'package:flutter/material.dart';

class AddTaskDialogState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add a new task"),
      content: AddTaskForm(),
    );
  }
}
