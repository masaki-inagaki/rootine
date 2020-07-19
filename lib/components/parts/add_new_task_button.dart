import 'package:flutter/material.dart';
import 'package:ROOTINE/components/edit_task_details.dart';
import 'package:intl/intl.dart';
import 'package:ROOTINE/components/parts/misc/datetime.dart';

class AddNewTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add_box),
      label: const Text('ADD A NEW TASK'),
      onPressed: () async {
        final date = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditTaskDetails(),
          ),
        );
        if (date != null && date != 'Cancel') {
          final DateFormat returnDF = new DateFormat('MMMd');
          final String returnDate = returnDF.format(date);
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Task added, will notify on ' +
                  returnDate +
                  dateSuffix(date))));
        }
      },
    );
  }
}
