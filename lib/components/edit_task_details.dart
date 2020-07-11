import 'package:ROOTINE/components/parts/add_task_form.dart';
import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';

class EditTaskDetails extends StatelessWidget {
  final Task task;
  EditTaskDetails({
    Key key,
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit: ' + task.taskName,
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
