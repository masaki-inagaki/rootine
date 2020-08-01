import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/config/const_text.dart';
import 'package:ROOTINE/components/parts/overdue/time_difference.dart';
import 'package:ROOTINE/components/parts/all_tasks/edit_task_details.dart';
import 'package:ROOTINE/language/app_local.dart';
import 'package:ROOTINE/models/settings_list.dart';
import 'package:ROOTINE/language/messages.dart';

class DismissibleList extends StatelessWidget {
  final Task task;
  const DismissibleList({
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

    var now = new DateTime.now();
    final tlist = context.watch<TaskList>();
    return Dismissible(
      key: ObjectKey(task),
      /*スワイプ時の背景の設定*/
      background: _buildBackGround(
          Colors.green, Icons.check, Alignment.centerLeft, 30.0, 0.0),
      secondaryBackground: _buildBackGround(
          Colors.yellow, Icons.timer, Alignment.centerRight, 0.0, 30.0),
      //スワイプされたときの確認
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return true;
        } else {
          var result = await _showSuspendDialog(context, task, msg);
          //キャンセルが押された場合はFalseを返し、Dismissしない。
          if (result == null) {
            return false;
            //In case of Pick date and time
          } else if (result.toString() == "More") {
            var dtResult = await _chooseDateTime(context, task);
            //In case cancelled
            if (dtResult == null) {
              return false;
            } else {
              task.dueDate = dtResult;
              tlist.update(task, context, msg);
              return true;
            }
            //In case Tomorrow is selected
          } else {
            task.dueDate = task.dueDate.add(new Duration(days: 1));
            tlist.update(task, context, msg);
            return true;
          }
        }
      },

      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          final postpone = TimeDifference(task: task).postpone();
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(
              content:
                  Text('This item is suspended for ' + postpone.toString())));
        } else {
          final DateTime oldDateTime = task.dueDate;
          task.dueDate = new DateTime(now.year, now.month, now.day + task.day);
          tlist.update(task, context, msg);
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(msg.snackbar['wellDone'](task.day)),
              action: SnackBarAction(
                  label: msg.snackbar['undo'],
                  onPressed: () {
                    /*Undoのときの処理*/
                    task.dueDate = oldDateTime;
                    tlist.update(task, context, msg);
                  })));
        }
      },
      child: buildRow(context, task),
    );
  }

  Widget _buildBackGround(
      Color c, IconData icn, Alignment aln, double lft, double rght) {
    return Container(
        color: c,
        padding: EdgeInsets.only(left: lft, right: rght),
        child: Align(alignment: aln, child: Icon(icn)));
  }

  Widget buildRow(BuildContext context, Task task) {
    // return ListTile(
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: ListTile(
          title: Text(
            task.taskName,
            overflow: TextOverflow.ellipsis,
            style: ConstStyle.listFont,
          ),
          trailing: _showDueTime(task, context),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTaskDetails(task: task),
              ),
            );
          }),
    );
  }

  Future _showSuspendDialog(
      BuildContext context, Task task, Messages msg) async {
    String result = "";
    result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(msg.postpone['alertMessage']),
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 80,
                width: 200,
                child: Row(
                  children: <Widget>[
                    Container(
                      //width: 80,
                      child: _buildDialogOption(msg.postpone['cancel'], null,
                          context, Colors.white, Colors.black, 50),
                    ),
                    Container(
                      //width: 100,
                      child: _buildDialogOption(msg.postpone['tomorrow'],
                          ' Tomorrow', context, Colors.blue, Colors.white, 50),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 20,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: _buildDialogOption(msg.postpone['pickTimeDate'],
                      'More', context, Colors.white, Colors.black, 20),
                ),
              ),
            ),
          ],
        );
      },
    );
    if (result != "") {
      //_result = result;
      return result;
    }
  }

  Widget _buildDialogOption(String t, String rt, BuildContext context,
      Color color, Color textColor, double height) {
    return ButtonTheme(
      height: height,
      child: FlatButton(
        onPressed: () {
          Navigator.pop(context, rt);
        },
        color: color,
        child: Text(
          t,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  Widget _showDueTime(Task task, BuildContext context) {
    final sList = context.watch<SettingsList>();
    final currentLang = sList.languageSettings;

    if (currentLang == null) {
      return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
    }

    Messages msg = Lang(lang: currentLang.value).current(context);

    final list = TimeDifference(task: task).due();
    TextStyle style;
    if (list[2] == true) {
      style = TextStyle(color: Colors.blue);
      return Text(msg.dueTime['due'] + list[0] + msg.dueTime[list[1]],
          style: style);
    }
    style = TextStyle(fontWeight: FontWeight.w900, color: Colors.red);
    return Text(msg.dueTime['overdue'] + list[0] + msg.dueTime[list[1]],
        style: style);
  }

  Future _chooseDateTime(BuildContext context, Task task) async {
    var now = new DateTime.now();
    DateTime cTime = now.add(new Duration(days: 1));
    var date;

    date = await DatePicker.showDateTimePicker(context,
        //showTitleActions: true,
        minTime: now,
        currentTime: cTime,
        locale: LocaleType.en, onConfirm: (date) {
      return date;
    });
    return date;
  }
}
