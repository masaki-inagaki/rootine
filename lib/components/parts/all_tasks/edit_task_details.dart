import 'package:ROOTINE/components/parts/add_edit_task/add_task_form.dart';
import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';

class EditTaskDetails extends StatelessWidget {
  final Task task;
  EditTaskDetails({
    Key key,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    String barTitle;
    if (task == null) {
      barTitle = "Add a new task";
    } else {
      barTitle = "Edit: " + task.taskName;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          barTitle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
        child: AddTaskForm(task: task),
      ),
    );
  }
}
