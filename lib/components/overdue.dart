import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/config/const_text.dart';

class Rootine extends StatefulWidget {
  @override
  RootineState createState() => RootineState();
}

class RootineState extends State<Rootine> {
  final dateTextController = TextEditingController();
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ConstText.todoTitle), actions: <Widget>[]),
      body: _buildOverdueList(),
    );
  }

  Widget _buildOverdueList() {
    final tlist = context.watch<TaskList>();
    final model = tlist.currentList;
    var now = new DateTime.now();
    var postponeDays = 3;

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: model.length,
      itemBuilder: (context, int i) {
        final item = model[i];
        return Dismissible(
          key: ObjectKey(item),

          /*スワイプ時の背景の設定*/
          background: _buildBackGround(
              Colors.green, Icons.check, Alignment.centerLeft, 30.0, 0.0),
          secondaryBackground: _buildBackGround(
              Colors.yellow, Icons.timer, Alignment.centerRight, 0.0, 30.0),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              return true;
            } else {
              await _showSuspendDialog();
              return _result != 'Cancel';
            }
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              item.dueDate =
                  new DateTime(now.year, now.month, now.day + postponeDays);
              tlist.update(item);
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text(item.taskName + ' suspended')));
            } else {
              item.dueDate =
                  new DateTime(now.year, now.month, now.day + item.day);
              tlist.update(item);
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(item.taskName + ' dismissed'),
                  action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        /*Undoのときの処理*/
                      })));
            }
          },
          child: buildRow(item),
        );
      },
    );
  }

  Future _showSuspendDialog() async {
    String result = "";
    result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Postpone the task?"),
          children: <Widget>[
            _buildDialogOption('Tomorrow', ' Tomorrow'),
            _buildDialogOption('Cancel', 'Cancel'),
          ],
        );
      },
    );
    if (result != "") {
      _result = result;
    }
  }

  Widget _buildDialogOption(String t, String rt) {
    return SimpleDialogOption(
      child: ListTile(
        title: Text(t),
      ),
      onPressed: () {
        Navigator.pop(context, rt);
      },
    );
  }

  Widget _buildBackGround(
      Color c, IconData icn, Alignment aln, double lft, double rght) {
    return Container(
        color: c,
        padding: EdgeInsets.only(left: lft, right: rght),
        child: Align(alignment: aln, child: Icon(icn)));
  }

  Widget buildRow(Task task) {
    return ListTile(
      title: Text(
        task.taskName,
        style: ConstStyle.listFont,
      ),
    );
  }
}
