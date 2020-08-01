import 'package:ROOTINE/components/parts/all_tasks/delete_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ROOTINE/config/const_text.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/components/parts/all_tasks/edit_task_details.dart';
import 'package:ROOTINE/language/app_local.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/language/messages.dart';
import 'package:ROOTINE/models/settings_list.dart';

class SlidableList extends StatelessWidget {
  final Task task;
  SlidableList({
    Key key,
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final sList = context.watch<SettingsList>();
    final currentLang = sList.languageSettings;

    if (currentLang == null) {
      return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
    }

    Messages msg = Lang(lang: currentLang.value).current(context);

    var noticeTime = msg.slidable['disabled'];
    if (task.useTime == true && task.noticeTime != null) {
      noticeTime = task.noticeTime;
    }

    final String listSubtitle = (msg.slidable['interval'] +
        ": " +
        msg.slidable['day'](task.day) +
        //intToDays(task.day) +
        ", " +
        msg.slidable['nextDueDate'] +
        ": " +
        // dueDate +
        msg.slidable['dueDate'](task.dueDate) +
        '\n' +
        msg.slidable['noticeTime'] +
        ": " +
        noticeTime);
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
                editTask(context, task, msg);
              }),
        ),
        actions: <Widget>[
          IconSlideAction(
              caption: msg.slidable['edit'],
              color: Colors.blue,
              icon: Icons.edit,
              onTap: () {
                editTask(context, task, msg);
              }),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: msg.slidable['delete'],
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
                    SnackBar(content: Text(msg.snackbar['delete'](result))));
              }
            },
          )
        ],
      ),
    );
  }

  void editTask(BuildContext context, Task task, Messages msg) async {
    final date = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditTaskDetails(task: task),
        ));
    if (date != null && date != 'Cancel') {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(msg.snackbar['edited'](task.dueDate))));
    }
  }
}
