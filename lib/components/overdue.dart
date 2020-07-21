import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:ROOTINE/components/parts/overdue/task_empty.dart';
import 'package:ROOTINE/config/const_text.dart';
import 'package:ROOTINE/components/parts/dismissible_list.dart';
import 'package:ROOTINE/components/parts/add_new_task_button.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

class Rootine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ConstText.todoTitle), actions: <Widget>[]),
      body: _buildOverdueList(context),
      floatingActionButton: AddNewTaskButton(),
    );
  }

  Widget _buildOverdueList(BuildContext context) {
    final tlist = context.watch<TaskList>();
    final list = tlist.currentList;

    if (list.isEmpty) {
      FlutterAppBadger.removeBadge();
      return TaskEmpty();
    }

    FlutterAppBadger.updateBadgeCount(list.length);

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: list.length,
      itemBuilder: (context, int i) {
        return DismissibleList(task: list[i]);
      },
    );
  }
}
