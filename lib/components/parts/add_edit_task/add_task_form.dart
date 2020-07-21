import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:intl/intl.dart';
import 'package:ROOTINE/components/parts/add_edit_task/form.dart';

class AddTaskForm extends StatefulWidget {
  final Task task;
  AddTaskForm({Key key, this.task}) : super(key: key);
  @override
  AddTaskFormState createState() => new AddTaskFormState();
}

// Widgetから呼ばれるStateクラス
class AddTaskFormState extends State<AddTaskForm> {
  final titleTextController = TextEditingController();
  final intervalTextController = TextEditingController();
  final timeTextController = TextEditingController();
  final firstDayController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showMoreVisibility = false;
  int showHideInt = 0;
  bool useNoticeTime = false;
  List<Text> showHidetext = [Text('Show options'), Text('Hide options')];
  List<Icon> showHideIcon = [Icon(Icons.expand_more), Icon(Icons.expand_less)];

  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    String saveButton = "Add";
    String noticeDayTitle = "First Notice Date";

    if (widget.task != null) {
      titleTextController.text = widget.task.taskName;
      intervalTextController.text = widget.task.day.toString();
      final String hour = widget.task.dueDate.hour.toString().padLeft(2, "0");
      final String min = widget.task.dueDate.minute.toString().padLeft(2, "0");
      timeTextController.text = hour + ':' + min;
      final DateFormat df = new DateFormat('yyyy-MM-dd');
      firstDayController.text = df.format(widget.task.dueDate);
      saveButton = "Done";
      noticeDayTitle = "Next Notice Date";
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(child: titleForm(titleTextController)),
          _intervalArea(),
          _optionFields(context, showMoreVisibility, noticeDayTitle),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                _showHideArea(),
                _buttonArea(context, saveButton, tlist),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _intervalArea() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 150,
          child: intervalForm(intervalTextController),
        ));
  }

  Widget _optionFields(BuildContext context, bool show, String labelTitle) {
    return Visibility(
      maintainSize: false,
      maintainAnimation: true,
      maintainState: true,
      visible: show,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Text('Use notice time'),
              ),
              Container(
                  child: Switch(
                value: useNoticeTime,
                onChanged: (value) {
                  setState(() {
                    useNoticeTime = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              )),
            ],
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 150,
                child: timeForm(context, timeTextController, useNoticeTime),
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

  Widget _showHideArea() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showMoreVisibility = !showMoreVisibility;
          showHideInt = showMoreVisibility ? 1 : 0;
        });
      },
      child: Row(
        children: <Widget>[
          showHidetext[showHideInt],
          showHideIcon[showHideInt],
        ],
      ),
    );
  }

  Widget _buttonArea(BuildContext context, String button, TaskList tlist) {
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 90,
                height: 50,
                margin: const EdgeInsets.only(top: 5.0),
                child: FlatButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: Text('Cancel')),
              ),
              Container(
                  width: 90,
                  height: 50,
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
      newTask.useTime = useNoticeTime;
      newTask.noticeTime = time;
      if (widget.task == null) {
        tList.add(newTask);
      } else {
        newTask.id = widget.task.id;
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
