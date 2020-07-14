import 'package:ROOTINE/components/parts/add_task_form.dart';
import 'package:flutter/material.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({Key key}) : super(key: key);

  @override
  AddTaskDialogState createState() => AddTaskDialogState();
}

class AddTaskDialogState extends State<AddTaskDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add a new task"),
      content: AddTaskForm(),
    );
  }
}
