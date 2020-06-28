import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/models/task_list.dart';
//import 'package:ROOTINE/Database.dart';

class AddTaskDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    final titleTextController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return AlertDialog(
        title: Text("Add a new task"),
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: titleTextController,
                enabled: true,
                maxLength: 20,
                maxLengthEnforced: false,
                obscureText: false,
                autovalidate: false,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText: 'Task description', labelText: 'New Task'),
                validator: (String value) {
                  return value.isEmpty ? 'This field is mandatory' : null;
                },
              ),
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Client _add = new Client();
                    _add.lastName = titleTextController.text;
                    tlist.add(_add);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        ));
  }
}

// class AddList extends StatelessWidget {
//   final String txt;
//   AddList({this.txt});

//   @override
//   Widget build(BuildContext context) {
//     print("AddListが呼び出されました");
//     print("txtは、$txt です");
//     final tlist = context.watch<TaskList>();
//     //final model = context.select((TaskList tlist) => tlist.currentList);
//     Client _add = new Client();
//     _add.lastName = txt;
//     //DBProvider.db.newClient(_add);
//     print("追加します");
//     tlist.add(_add);
//     return null;
//   }
// }

//   void _addList(BuildContext context, bool result, String txt) async {
//     final tlist = context.watch<TaskList>();
//     //final model = context.select((TaskList tlist) => tlist.currentList);
//     print("_addListが呼び出されました");
//     if (result == true) {
//       Client _add = new Client();
//       _add.lastName = txt;
//       await DBProvider.db.newClient(_add);
//       print(_add);
//       tlist.add(_add);
//     }
//   }
// }
