import 'package:ROOTINE/components/parts/todo_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_list.dart';

// class ShowTodoList extends StatefulWidget {
//   @override
//   ShowTodoListState createState() => ShowTodoListState();
// }

// class ShowTodoListState extends State<ShowTodoList> {

class ShowTodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    final list = tlist.allTaskList;
    //final list = context.select((TaskList tlist) => tlist.currentList);
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL TASKS'),
      ),
      body: TodoListView(list: list),
    );
  }
}
