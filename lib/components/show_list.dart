import 'package:flutter/material.dart';
import 'package:ROOTINE/models/TaskModel.dart';
import 'package:ROOTINE/Database.dart';
import 'package:ROOTINE/config/const_text.dart';

class ShowTodoList extends StatefulWidget {
  @override
  ShowTodoListState createState() => ShowTodoListState();
}

class ShowTodoListState extends State<ShowTodoList> {

  @override
  Widget build (BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text('ROUTINES'),
      ),
      body: FutureBuilder<List<Client>>(
        future: DBProvider.db.getAllClients(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          var data = snapshot.data;
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: data.length,
            itemBuilder: (context, int i) {
              final item = data[i];
              return buildRow(item.lastName);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_box),
        label: const Text('ADD A NEW TASK'),
        onPressed: () {
          _showNewRootineDialog(context);
        },
      ),
    );
  }

  Future _showNewRootineDialog(BuildContext context) async {
    final titleTextController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (buildContext) {
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
                        _addList(true, titleTextController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _addList(bool result, String txt) async {
    //Navigator.pop(context);
    setState(() async {
      if (result == true) {
        Client _add = new Client();
        _add.lastName = txt;
        await DBProvider.db.newClient(_add);
      }
    });
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