import 'package:ROOTINE/components/parts/all_tasks/slidable_list.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:ROOTINE/components/parts/overdue/task_empty.dart';

class TodoListView extends StatelessWidget {
  final List<Task> list;
  TodoListView({
    @required this.list,
  });

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      TaskEmpty();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int i) {
        //return TodoListRow(itm: list[i]);
        return SlidableList(task: list[i]);
      },
    );
  }
}
