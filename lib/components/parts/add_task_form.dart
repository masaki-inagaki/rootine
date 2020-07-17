import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:intl/intl.dart';

class AddTaskForm extends StatelessWidget {
  final Task task;
  AddTaskForm({
    Key key,
    this.task,
  });
  final titleTextController = TextEditingController();
  final dayTextController = TextEditingController();
  final timeTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    String saveButton = "Add";

    if (task != null) {
      titleTextController.text = task.taskName;
      dayTextController.text = task.day.toString();
      final String hour = task.dueDate.hour.toString().padLeft(2, "0");
      final String min = task.dueDate.minute.toString().padLeft(2, "0");
      timeTextController.text = hour + ':' + min;
      saveButton = "Done";
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(child: _titleForm()),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 150,
                child: _intervalForm(),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 150,
                child: _timeForm(context),
              )),
          Container(
            //margin: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 200,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 90,
                      margin: const EdgeInsets.only(top: 5.0),
                      child: FlatButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: Text('Cancel')),
                    ),
                    Container(
                        width: 90,
                        margin: const EdgeInsets.only(top: 5.0),
                        child: _saveButton(context, saveButton, tlist)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  Widget _titleForm() {
    return new TextFormField(
      controller: titleTextController,
      enabled: true,
      maxLength: 40,
      maxLengthEnforced: true,
      autovalidate: false,
      autofocus: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: 'Input task title', labelText: 'Task Title'),
      validator: (String value) {
        return value.isEmpty ? 'Mandatory field' : null;
      },
    );
  }

  Widget _intervalForm() {
    return new TextFormField(
      controller: dayTextController,
      enabled: true,
      maxLength: 3,
      maxLengthEnforced: true,
      //obscureText: false,
      autovalidate: false,
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          hintText: '1 ~ 999', labelText: 'Interval Day(s)'),
      validator: (input) {
        //return input.isEmpty ? 'This field is mandatory' : null;
        final isDigitsOnly = int.tryParse(input);
        if (input.isEmpty) {
          return 'Mandatory field';
        } else if (isDigitsOnly == null) {
          return 'Digits only';
        } else if (int.parse(input) == 0) {
          return '1 ~ 999';
        } else {
          return null;
        }
      },
    );
  }

  Widget _timeForm(BuildContext context) {
    return new TextFormField(
      controller: timeTextController,
      enabled: true,
      maxLength: 5,
      maxLengthEnforced: true,
      autovalidate: false,
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: 'Notice Time',
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
          return 'Digits and colon only';
        } else {
          return timeChecker(time);
        }
      },
    );
  }

  Widget _saveButton(
      BuildContext context, String buttonString, TaskList taskList) {
    var now = new DateTime.now();
    return FlatButton(
      color: Colors.blue,
      textTheme: ButtonTextTheme.primary,
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
          _add.noticeTime = time;
          if (_add.id == null) {
            taskList.add(_add);
          } else {
            taskList.update(_add);
          }
          String dayTrailer = ' day';
          if (_add.day != 1) {
            dayTrailer = dayTrailer + 's';
          }
          Navigator.pop(context, _add.day.toString() + dayTrailer);
        }
      },
      child: Text(buttonString),
    );
  }
}
