import 'package:flutter/material.dart';
import 'package:ROOTINE/components/parts/add_task_dialog.dart';

class AddNewTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String result;
    return FloatingActionButton.extended(
      icon: Icon(Icons.add_box),
      label: const Text('ADD A NEW TASK'),
      onPressed: () async {
        result = await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (buildContext) {
            return AddTaskDialog();
          },
        );
        if (result != 'Cancel') {
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Task added, will notify after ' + result)));
        }
      },
    );
  }
}
