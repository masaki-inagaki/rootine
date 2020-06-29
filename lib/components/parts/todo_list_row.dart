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
    return ListTile(
      title: Text(
        itm.taskName,
        style: ConstStyle.listFont,
      ),
    );
  }
}
