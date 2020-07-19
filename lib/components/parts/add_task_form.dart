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
  final firstDayController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    String saveButton = "Add";
    String noticeday = "First Notice Date";

    if (task != null) {
      titleTextController.text = task.taskName;
      dayTextController.text = task.day.toString();
      final String hour = task.dueDate.hour.toString().padLeft(2, "0");
      final String min = task.dueDate.minute.toString().padLeft(2, "0");
      timeTextController.text = hour + ':' + min;
      final DateFormat df = new DateFormat('yyyy-MM-dd');
      firstDayController.text = df.format(task.dueDate);
      saveButton = "Done";
      noticeday = "Next Notice Date";
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
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 200,
                child: _firstNoticeDate(context, noticeday),
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
        if (input.isEmpty) {
          return null;
        }
        final String time = input.replaceAll(':', '');
        if (int.tryParse(time) == null) {
          return 'Digits and colon only';
        }
        return timeChecker(time);
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
          var time;
          if (timeTextController.text.isEmpty ||
              timeTextController.text == null) {
            time = "2359";
          } else {
            time = timeTextController.text.replaceAll(':', '');
            if (time.length == 3) {
              time = '0' + time;
            }
          }
          final int mm = int.parse(time.substring(0, 2));
          final int ss = int.parse(time.substring(2, 4));

          final newTask = new Task();
          newTask.taskName = titleTextController.text;
          newTask.day = int.parse(dayTextController.text);
          if (firstDayController.text.isEmpty) {
            newTask.dueDate = new DateTime(now.year, now.month,
                now.day + int.parse(dayTextController.text), mm, ss);
          } else {
            final DateTime newDate = DateTime.parse(firstDayController.text);
            newTask.dueDate =
                new DateTime(newDate.year, newDate.month, newDate.day, mm, ss);
          }
          newTask.noticeTime = time;
          if (task == null) {
            taskList.add(newTask);
          } else {
            newTask.id = task.id;
            taskList.update(newTask);
          }
          String dayTrailer = ' day';
          if (newTask.day != 1) {
            dayTrailer = dayTrailer + 's';
          }
          Navigator.pop(context, newTask.day.toString() + dayTrailer);
        }
      },
      child: Text(buttonString),
    );
  }

  Widget _firstNoticeDate(BuildContext context, String noticeday) {
    return new TextFormField(
      controller: firstDayController,
      enabled: true,
      autovalidate: false,
      autofocus: false,
      decoration: InputDecoration(
          labelText: noticeday,
          hintText: 'Tap calendar icon',
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              final DateTime firstDay = await _selectDate(context);
              if (firstDay != null) {
                final DateFormat df = new DateFormat('yyyy-MM-dd');
                firstDayController.text = df.format(firstDay);
              }
            },
          )),
      validator: (input) {
        if (input.isEmpty) {
          return null;
        } else if (DateTime.tryParse(input) == null) {
          return 'Incorrect date';
        } else {
          return null;
        }
      },
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime dt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(new Duration(days: 365)),
    );
    if (dt != null) {
      return dt;
    } else {
      return null;
    }
  }
}
