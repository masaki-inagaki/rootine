import 'package:ROOTINE/components/parts/delete_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ROOTINE/config/const_text.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/components/edit_task_details.dart';

class SlidableList extends StatelessWidget {
  final Task task;
  SlidableList({
    Key key,
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    String dayTrailer = "day";
    if (task.day > 1) {
      dayTrailer = dayTrailer + "s";
    }
    final dueDate = task.dueDate.year.toString() +
        '/' +
        task.dueDate.month.toString() +
        '/' +
        task.dueDate.day.toString();
    final notificationTime = task.dueDate.hour.toString().padLeft(2, '0') +
        ':' +
        task.dueDate.minute.toString().padLeft(2, '0');

    final String listSubtitle = ("Interval: " +
            task.day.toString() +
            dayTrailer +
            ", Due Date: " +
            dueDate) +
        '\n' +
        'Notification Time: ' +
        notificationTime;
    String result;

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
            title: Text(task.taskName, style: ConstStyle.listFont),
            subtitle: Text(listSubtitle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskDetails(task: task),
                ),
              );
            }),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskDetails(task: task),
                ));
          },
        ),
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
    );
  }
}
