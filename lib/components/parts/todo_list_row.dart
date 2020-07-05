import 'package:ROOTINE/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:ROOTINE/config/const_text.dart';

class TodoListRow extends StatelessWidget {
  final Task itm;
  TodoListRow({
    Key key,
    this.itm,
  });

  @override
  Widget build(BuildContext context) {
    String dayTrailer = "day";
    if (itm.day > 1) {
      dayTrailer = dayTrailer + "s";
    }
    return ListTile(
      title: Text(
        itm.taskName,
        style: ConstStyle.listFont,
      ),
      subtitle: Text("Interval: " +
          itm.day.toString() +
          dayTrailer +
          ", Due Date: " +
          itm.dueDate.toString()),
    );
  }
}
