import 'package:flutter/material.dart';
import 'package:ROOTINE/components/edit_task_details.dart';

class AddNewTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add_box),
      label: const Text('ADD A NEW TASK'),
      onPressed: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditTaskDetails(),
          ),
        );
        if (result != null && result != 'Cancel') {
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Task added, will notify after ' + result)));
        }
      },
    );
  }
}
