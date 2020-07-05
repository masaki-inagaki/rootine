import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/models/task_list.dart';

class AddTaskDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    final titleTextController = TextEditingController();
    final dayTextController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    var now = new DateTime.now();

    return AlertDialog(
        title: Text("Add a new task"),
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              new TextFormField(
                controller: titleTextController,
                enabled: true,
                maxLength: 40,
                maxLengthEnforced: true,
                //obscureText: false,
                autovalidate: false,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText: 'Task description', labelText: 'New Task'),
                validator: (String value) {
                  return value.isEmpty ? 'This field is mandatory' : null;
                },
              ),
              new TextFormField(
                controller: dayTextController,
                enabled: true,
                maxLength: 4,
                maxLengthEnforced: true,
                //obscureText: false,
                autovalidate: false,
                autofocus: false,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: ' Input the interval days for this task',
                    labelText: 'Interval days'),
                validator: (input) {
                  //return input.isEmpty ? 'This field is mandatory' : null;
                  final isDigitsOnly = int.tryParse(input);
                  if (input.isEmpty) {
                    return 'This field is mandatory';
                  } else if (isDigitsOnly == null) {
                    return 'Input needs to be digits only';
                  } else {
                    return null;
                  }
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
                    _add.day = int.parse(dayTextController.text);
                    _add.dueDate =
                        new DateTime(now.year, now.month, now.day + _add.day);
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
