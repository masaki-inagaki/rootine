import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:intl/intl.dart';
import 'package:ROOTINE/components/parts/add_edit_task/form.dart';

class AddTaskForm extends StatelessWidget {
  final Task task;
  AddTaskForm({
    Key key,
    this.task,
  });
  final titleTextController = TextEditingController();
  final intervalTextController = TextEditingController();
  final timeTextController = TextEditingController();
  final firstDayController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    String saveButton = "Add";
    String noticeDayTitle = "First Notice Date";
    bool showMoreVisibility = true;

    if (task != null) {
      titleTextController.text = task.taskName;
      intervalTextController.text = task.day.toString();
      final String hour = task.dueDate.hour.toString().padLeft(2, "0");
      final String min = task.dueDate.minute.toString().padLeft(2, "0");
      timeTextController.text = hour + ':' + min;
      final DateFormat df = new DateFormat('yyyy-MM-dd');
      firstDayController.text = df.format(task.dueDate);
      saveButton = "Done";
      noticeDayTitle = "Next Notice Date";
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(child: titleForm(titleTextController)),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 150,
                child: intervalForm(intervalTextController),
              )),
          _optionFields(context, showMoreVisibility, noticeDayTitle),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showMoreVisibility = !showMoreVisibility;
                },
                child: Row(
                  children: <Widget>[
                    Text('Show options'),
                    Icon(Icons.unfold_more),
                  ],
                ),
              ),
              _buttonArea(context, saveButton, tlist),
            ],
          ),
        ],
      ),
    );
  }

  Widget _optionFields(BuildContext context, bool show, String labelTitle) {
    return Visibility(
      maintainSize: false,
      maintainAnimation: true,
      maintainState: true,
      visible: show,
      child: Column(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 150,
                child: timeForm(context, timeTextController),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 200,
                child: firstNoticeDate(context, labelTitle, firstDayController),
              )),
        ],
      ),
    );
  }

  Widget _buttonArea(BuildContext context, String button, TaskList tlist) {
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          //width: 200,
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
                  child: _saveButton(context, button, tlist)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _saveButton(
      BuildContext context, String buttonString, TaskList tList) {
    return FlatButton(
      color: Colors.blue,
      textTheme: ButtonTextTheme.primary,
      onPressed: () {
        _saveTask(context, tList);
      },
      child: Text(buttonString),
    );
  }

  _saveTask(BuildContext context, TaskList tList) {
    var now = new DateTime.now();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var time;
      if (timeTextController.text.isEmpty || timeTextController.text == null) {
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
      newTask.day = int.parse(intervalTextController.text);
      if (firstDayController.text.isEmpty) {
        newTask.dueDate = new DateTime(now.year, now.month,
            now.day + int.parse(intervalTextController.text), mm, ss);
      } else {
        final DateTime newDate = DateTime.parse(firstDayController.text);
        newTask.dueDate =
            new DateTime(newDate.year, newDate.month, newDate.day, mm, ss);
      }
      newTask.noticeTime = time;
      if (task == null) {
        tList.add(newTask);
      } else {
        newTask.id = task.id;
        tList.update(newTask);
      }
      String dayTrailer = ' day';
      if (newTask.day != 1) {
        dayTrailer = dayTrailer + 's';
      }
      Navigator.pop(context, newTask.dueDate);
    }
  }
}
