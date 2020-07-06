import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:intl/intl.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({Key key}) : super(key: key);

  @override
  AddTaskDialogState createState() => AddTaskDialogState();
}

class AddTaskDialogState extends State<AddTaskDialog> {
//class AddTaskDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    final titleTextController = TextEditingController();
    final dayTextController = TextEditingController();
    final timeTextController = TextEditingController();
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
                    hintText: 'Input task title', labelText: 'New Task Title'),
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
                    hintText: 'Reminds you after xx days',
                    labelText: 'Interval days'),
                validator: (input) {
                  //return input.isEmpty ? 'This field is mandatory' : null;
                  final isDigitsOnly = int.tryParse(input);
                  if (input.isEmpty) {
                    return 'This field is mandatory';
                  } else if (isDigitsOnly == null) {
                    return 'Input needs to be digits only';
                  } else if (int.parse(input) == 0) {
                    return 'Input should not be zero';
                  } else {
                    return null;
                  }
                },
              ),
              new TextFormField(
                controller: timeTextController,
                //initialValue: "00:00",
                enabled: true,
                maxLength: 5,
                maxLengthEnforced: true,
                //obscureText: false,
                autovalidate: false,
                autofocus: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Notification Time',
                    hintText: '00:00',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.timer),
                      onPressed: () async {
                        var time = await _selectTime(context);
                        timeTextController.text = time.toString();
                      },
                    )),
                validator: (input) {
                  final String time = input.replaceAll(':', '');
                  final isDigitsOnly = int.tryParse(time);
                  if (input != null && isDigitsOnly == null) {
                    return 'Input needs to be digits and colon only';
                  } else {
                    return timeChecker(time);
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
                    var time = timeTextController.text.replaceAll(':', '');
                    if (time.length == 3) {
                      time = '0' + time;
                    }
                    Task _add = new Task();
                    _add.taskName = titleTextController.text;
                    _add.day = int.parse(dayTextController.text);
                    _add.dueDate = new DateTime(
                        now.year,
                        now.month,
                        now.day + int.parse(dayTextController.text),
                        int.parse(time.substring(0, 2)),
                        int.parse(time.substring(2, 4)));
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

  Future<String> _selectTime(BuildContext context) async {
    final TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null) {
      var dt = _toDateTime(t);
      return DateFormat.Hm().format(dt);
    } else {
      return null;
    }
  }

  _toDateTime(TimeOfDay t) {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day, t.hour, t.minute);
  }

  String timeChecker(String time) {
    final timeerror = "Input time is wrong";
    if (time.length == 3) {
      time = "0" + time;
    }
    if (time.length == 4 &&
        int.parse(time.substring(0, 2)) < 24 &&
        int.parse(time.substring(2, 4)) < 60) {
      return null;
    } else {
      return timeerror;
    }
  }
}
