import 'package:ROOTINE/components/parts/overdue/todo_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:ROOTINE/components/parts/overdue/task_empty.dart';

class ShowTodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    final list = tlist.allTaskList;

    if (list.isEmpty) {
      return TaskEmpty();
    }
    return TodoListView(list: list);
  }
}
