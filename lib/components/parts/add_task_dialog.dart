import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/models/task_list.dart';

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
                    Task _add = new Task();
                    _add.taskName = titleTextController.text;
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
