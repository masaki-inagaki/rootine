import 'package:ROOTINE/components/parts/add_edit_task/add_task_form.dart';
import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/language/app_local.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/language/messages.dart';
import 'package:ROOTINE/models/settings_list.dart';

class EditTaskDetails extends StatelessWidget {
  final Task task;
  EditTaskDetails({
    Key key,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    final sList = context.watch<SettingsList>();
    final currentLang = sList.languageSettings;

    if (currentLang == null) {
      return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
    }

    Messages msg = Lang(lang: currentLang.value).current(context);

    final String barTitle = task == null
        ? msg.newTask['addANewTask']
        : msg.newTask['edit'] + ': ' + task.taskName;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          barTitle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
        child: AddTaskForm(task: task),
      ),
    );
  }
}
