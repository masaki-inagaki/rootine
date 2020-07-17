import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/config/const_text.dart';
import 'package:ROOTINE/components/parts/time_difference.dart';
import 'package:ROOTINE/components/edit_task_details.dart';

class DismissibleList extends StatelessWidget {
  final Task task;
  const DismissibleList({
    Key key,
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    final tlist = context.watch<TaskList>();
    String dayTrailer = ' day';
    if (task.day != 1) {
      dayTrailer = dayTrailer + 's';
    }

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
          var result = await _showSuspendDialog(context, task);
          //キャンセルが押された場合はFalseを返し、Dismissしない。
          if (result == null) {
            return false;
          } else if (result == "More") {
            await _showMoreOptions(context, task);
            return false;
          } else {
            return true;
          }
        }
      },
      //スワイプされたときの動作
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          task.dueDate = new DateTime(now.year, now.month, now.day + task.day);
          tlist.update(task);
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('This item is suspended for ' +
                  task.day.toString() +
                  dayTrailer)));
        } else {
          final DateTime oldDateTime = task.dueDate;
          task.dueDate = new DateTime(now.year, now.month, now.day + task.day);
          tlist.update(task);
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Well done!! Reminds you again after ' +
                  task.day.toString() +
                  dayTrailer),
              action: SnackBarAction(
                  label: "Undo",
                  onPressed: () {
                    /*Undoのときの処理*/
                    task.dueDate = oldDateTime;
                    tlist.update(task);
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
    return ListTile(
        title: Text(
          task.taskName,
          overflow: TextOverflow.ellipsis,
          style: ConstStyle.listFont,
        ),
        trailing: TimeDifference(task: task),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTaskDetails(task: task),
            ),
          );
        });
  }

  Future _showSuspendDialog(BuildContext context, Task task) async {
    String result = "";
    result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Postpone the task?"),
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
                      child: _buildDialogOption('Cancel', null, context,
                          Colors.white, Colors.black, 50),
                    ),
                    Container(
                      //width: 100,
                      child: _buildDialogOption('Tomorrow', ' Tomorrow',
                          context, Colors.blue, Colors.white, 50),
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
                  child: _buildDialogOption('More Options', 'More', context,
                      Colors.white, Colors.black, 20),
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

  Future _showMoreOptions(BuildContext context, Task task) async {
    String result = "";
    result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Postpone the task?"),
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
                      child: _buildDialogOption('Cancel', null, context,
                          Colors.white, Colors.black, 50),
                    ),
                    Container(
                      //width: 100,
                      child: _buildDialogOption('Tomorrow', ' Tomorrow',
                          context, Colors.blue, Colors.white, 50),
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
                  child: _buildDialogOption('More Options', 'More', context,
                      Colors.white, Colors.black, 20),
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
}
