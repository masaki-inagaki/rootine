import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:provider/provider.dart';

class TaskEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    final list = tlist.allTaskList;

    return Center(
      child: _container(list, context),
    );
  }

  Widget _container(List<Task> list, BuildContext context) {
    if (list.isEmpty) {
      return Container(
          width: 300.0,
          height: 150.0,
          child: Text(
              "You have no task now.\nClick the button below to add your first task",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              )));
    } else {
      return Container(
        width: 200.0,
        height: 200.0,
        child: Column(children: <Widget>[
          Center(
            child: Image.asset(
              'image/all_done.png',
              width: 120,
              height: 120,
            ),
          ),
          Center(
            child: Text(
              'Well done!!\nYou have no task for now.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ]),
      );
    }
  }
}
