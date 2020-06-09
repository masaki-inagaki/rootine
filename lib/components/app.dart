import 'package:flutter/material.dart';
import 'package:ROOTINE/models/TaskModel.dart';
import 'package:ROOTINE/config/const_text.dart';
import 'package:ROOTINE/Database.dart';
import 'package:ROOTINE/components/show_list.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstText.appTitle,
      home: Rootine(),
    );
  }
}

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
      appBar: AppBar(title: Text(ConstText.todoTitle), actions: <Widget>[
        //IconButton(icon: Icon(Icons.list), onPressed: showList),
        IconButton(icon: Icon(Icons.list), onPressed: (){
          Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context){
            return ShowTodoList();
          }));
        })
      ]),
      body: _buildOverdueList(),
    );
  }

  // #docregion _buildSuggestions
  Widget _buildOverdueList() {
    return FutureBuilder<List<Client>>(
      future: DBProvider.db.getAllClients(),
      builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: data.length,
            itemBuilder: (context, int i) {
              final item = data[i];
              return Dismissible(
                key: ObjectKey(data[i]),

                /*スワイプ時の背景の設定*/
                background: _buildBackGround(Colors.green, Icons.check,
                    Alignment.centerLeft, 30.0, 0.0),
                secondaryBackground: _buildBackGround(Colors.yellow,
                    Icons.timer, Alignment.centerRight, 0.0, 30.0),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    return true;
                  } else {
                    await _showSuspendDialog();
                    return _result != 'Cancel';
                  }
                },
                onDismissed: (direction) {
                  setState(() {

                    if (direction == DismissDirection.endToStart) {
                      DBProvider.db.deleteClient(item.id);
                      //data.removeAt(i);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(item.lastName + ' suspended')));
                    } else {
                      DBProvider.db.deleteClient(item.id);
                      //data.removeAt(i);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(item.lastName + ' dismissed'),
                          action: SnackBarAction(
                              label: "Undo",
                              onPressed: () {
                                /*Undoのときの処理*/
                              })));
                    }                 
                  });
                },
                child: buildRow(item.lastName),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
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

  Widget buildRow(String itm) {
    return ListTile(
      title: Text(
        itm,
        style: ConstStyle.listFont,
      ),
    );
  }
}
