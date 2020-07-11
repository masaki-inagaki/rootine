import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_model.dart';

class DeleteConmfirmation extends StatelessWidget {
  final Task task;
  const DeleteConmfirmation({
    Key key,
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    return AlertDialog(
      title: Text('Are you really sure to delete this task?'),
      content: Text(task.taskName),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
            child: Text('Delete'),
            onPressed: () {
              tlist.remove(task);
              Navigator.pop(context, task.taskName);
            })
      ],
    );
  }
}
