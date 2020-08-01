import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:ROOTINE/components/parts/overdue/task_empty.dart';
import 'package:ROOTINE/components/parts/dismissible_list.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

class OverDue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    final list = tlist.currentList;

    if (list == null) {
      return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
    }

    if (list.isEmpty) {
      FlutterAppBadger.removeBadge();
      return TaskEmpty();
    }

    return ListView.builder(
      padding:
          const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0, bottom: 75.0),
      itemCount: list.length,
      itemBuilder: (context, int i) {
        return DismissibleList(task: list[i]);
      },
    );
  }
}
