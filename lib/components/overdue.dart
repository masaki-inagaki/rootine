import 'package:flutter/material.dart';
//import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/config/const_text.dart';

class Rootine extends StatelessWidget {
  final dateTextController = TextEditingController();
  //String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ConstText.todoTitle), actions: <Widget>[]),
      body: _buildOverdueList(context),
    );
  }

  Widget _buildOverdueList(BuildContext context) {
    final tlist = context.watch<TaskList>();
    final model = tlist.currentList;
    var now = new DateTime.now();
    var postponeDays = 0;

    if (model.isEmpty) {
      return Center(
        //child: Text("aaaa"),
        //child: Image(image: AssetImage('image/all_done.png')),
        child: Container(
          width: 120.0,
          height: 150.0,
          child: Column(children: <Widget>[
            Image(image: AssetImage('image/all_done.png')),
            Text('Well done!!'),
          ]),
        ),
      );
    }

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
              var result = await _showSuspendDialog(context);
              //キャンセルが押された場合はFalseを返し、Dismissしない。
              //return _result != 'Cancel';
              if (result == 'Cancel') {
                return false;
              } else {
                postponeDays = 3;
                return true;
              }
            }
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              item.dueDate =
                  new DateTime(now.year, now.month, now.day + postponeDays);
              tlist.update(item);
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('This item is suspended for ' +
                      postponeDays.toString() +
                      ' days')));
            } else {
              item.dueDate =
                  new DateTime(now.year, now.month, now.day + item.day);
              tlist.update(item);
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Well done!! Reminds you after ' +
                      item.day.toString() +
                      ' days'),
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

  Future _showSuspendDialog(BuildContext context) async {
    String result = "";
    result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Postpone the task?"),
          children: <Widget>[
            _buildDialogOption('Tomorrow', ' Tomorrow', context),
            _buildDialogOption('Cancel', 'Cancel', context),
          ],
        );
      },
    );
    if (result != "") {
      //_result = result;
      return result;
    }
  }

  Widget _buildDialogOption(String t, String rt, BuildContext context) {
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
