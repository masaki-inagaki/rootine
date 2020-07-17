import 'package:ROOTINE/components/parts/todo_list_view.dart';
import 'package:ROOTINE/config/const_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/components/parts/add_new_task_button.dart';
import 'package:ROOTINE/components/parts/task_empty.dart';

class ShowTodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    final list = tlist.allTaskList;
    return Scaffold(
      appBar: AppBar(
        title: Text(ConstText.allTasks),
      ),
      body: _builTaskList(context, list),
      floatingActionButton: AddNewTaskButton(),
    );
  }

  Widget _builTaskList(BuildContext context, List<Task> list) {
    if (list.isEmpty) {
      return TaskEmpty();
    }
    return TodoListView(list: list);
  }
}
