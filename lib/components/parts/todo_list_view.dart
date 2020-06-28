import 'package:ROOTINE/components/parts/todo_list_row.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:flutter/material.dart';

class TodoListView extends StatelessWidget{
  final List<Client> list;
  TodoListView({
    @required this.list,
  });

  @override
  Widget build(BuildContext context) {
    if(list.isEmpty) {
      return Center(child: Text("No Items"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int i) {
        return TodoListRow(itm: list[i]);
      },
    );
  }
}