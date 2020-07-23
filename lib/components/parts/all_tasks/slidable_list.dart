import 'package:ROOTINE/components/parts/all_tasks/delete_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ROOTINE/config/const_text.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/components/parts/all_tasks/edit_task_details.dart';
import 'package:ROOTINE/components/parts/misc/datetime.dart';
import 'package:intl/intl.dart';

class SlidableList extends StatelessWidget {
  final Task task;
  SlidableList({
    Key key,
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final suffix = dateSuffix(task.dueDate);
    final dueDate = DateFormat('MMMM d').format(task.dueDate) + suffix;

    var noticeTime = 'Disabled';
    if (task.useTime == true && task.noticeTime != null) {
      noticeTime = task.noticeTime;
    }
    print(task.useTime);
    print(task.noticeTime);

    final String listSubtitle =
        ("Interval: " + intToDays(task.day) + ", Next due Date: " + dueDate) +
            '\n' +
            'Notice Time: ' +
            noticeTime;
    String result;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
              title: Text(task.taskName, style: ConstStyle.listFont),
              subtitle: Text(listSubtitle),
              onTap: () {
                editTask(context, task);
              }),
        ),
        actions: <Widget>[
          IconSlideAction(
              caption: 'Edit',
              color: Colors.blue,
              icon: Icons.edit,
              onTap: () {
                editTask(context, task);
              }),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () async {
              result = await showDialog(
                context: context,
                barrierDismissible: true,
                builder: (buildContext) {
                  return DeleteConmfirmation(task: task);
                },
              );
              if (result != null) {
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Deleted the task: ' + result)));
              }
            },
          )
        ],
      ),
    );
  }

  void editTask(BuildContext context, Task task) async {
    final date = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditTaskDetails(task: task),
        ));
    if (date != null && date != 'Cancel') {
      final DateFormat returnDF = new DateFormat('MMMd');
      final String returnDate = returnDF.format(date);
      final message = Text(
          'Task edited, will notify you on ' + returnDate + dateSuffix(date));

      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(content: message));
    }
  }
}
