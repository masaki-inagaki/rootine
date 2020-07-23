import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:intl/intl.dart';
import 'package:ROOTINE/components/parts/add_edit_task/form.dart';
import 'package:ROOTINE/components/parts/misc/datetime.dart';

class AddTaskForm extends StatefulWidget {
  final Task task;
  AddTaskForm({Key key, this.task}) : super(key: key);
  @override
  AddTaskFormState createState() => new AddTaskFormState();
}

class AddTaskFormState extends State<AddTaskForm> {
  final titleTextController = TextEditingController();
  final intervalTextController = TextEditingController();
  final timeTextController = TextEditingController();
  final firstDayController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showMoreVisibility = false;
  int showHideInt = 0;
  bool useTime = false;
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    final tlist = context.watch<TaskList>();
    final bool existing = widget.task != null;

    if (widget.task != null && firstTime == true) {
      titleTextController.text = widget.task.taskName;
      intervalTextController.text = widget.task.day.toString();
      timeTextController.text = widget.task.noticeTime;
      firstDayController.text =
          DateFormat('yyyy-MM-dd').format(widget.task.dueDate);
      useTime = widget.task.useTime;
      firstTime = false;
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(child: titleForm(titleTextController)),
          _intervalArea(),
          _optionFields(context, showMoreVisibility, existing),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                _showHideArea(),
                _buttonArea(context, existing, tlist),
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

  Widget _optionFields(BuildContext context, bool show, bool existing) {
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
                value: useTime,
                onChanged: (value) {
                  setState(() {
                    useTime = value;
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
                child: timeForm(context, timeTextController, useTime),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 200,
                child: firstNoticeDate(context, existing, firstDayController),
              )),
        ],
      ),
    );
  }

  Widget _showHideArea() {
    List<Text> showHidetext = [Text('Show options'), Text('Hide options')];
    List<Icon> showHideIcon = [
      Icon(Icons.expand_more),
      Icon(Icons.expand_less)
    ];
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

  Widget _buttonArea(BuildContext context, bool existing, TaskList tlist) {
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
                  child: _saveButton(context, existing, tlist)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _saveButton(BuildContext context, bool existing, TaskList tList) {
    List<String> saveButton = ["Add", 'Done'];
    return FlatButton(
      color: Colors.blue,
      textTheme: ButtonTextTheme.primary,
      onPressed: () {
        _saveTask(context, tList);
      },
      child: Text(saveButton[existing ? 1 : 0]),
    );
  }

  _saveTask(BuildContext context, TaskList tList) {
    var now = new DateTime.now();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final String time =
          timeTextController.text.isEmpty || timeTextController.text == null
              ? ''
              : timeFormatter(timeTextController.text);
      final int mm = int.parse(time.substring(0, 2));
      final int ss = int.parse(time.substring(3, 5));

      //set the task parameters
      final newTask = new Task();
      newTask.taskName = titleTextController.text;
      if (firstDayController.text.isEmpty) {
        newTask.dueDate = new DateTime(now.year, now.month,
            now.day + int.parse(intervalTextController.text), mm, ss);
      } else {
        final DateTime newDate = DateTime.parse(firstDayController.text);
        newTask.dueDate =
            new DateTime(newDate.year, newDate.month, newDate.day, mm, ss);
      }
      newTask.useTime = useTime;
      newTask.noticeTime = time;
      newTask.day = int.parse(intervalTextController.text);

      print(newTask.noticeTime);
      if (widget.task == null) {
        tList.add(newTask);
      } else {
        newTask.id = widget.task.id;
        tList.update(newTask);
      }
      Navigator.pop(context, newTask.dueDate);
    }
  }
}
