import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/language/app_local.dart';
import 'package:ROOTINE/models/settings_list.dart';
import 'package:ROOTINE/language/messages.dart';

class TaskEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sList = context.watch<SettingsList>();
    final currentLang = sList.languageSettings;

    if (currentLang == null) {
      return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
    }

    Messages msg = Lang(lang: currentLang.value).current(context);

    final tlist = context.watch<TaskList>();
    final list = tlist.allTaskList;

    return Center(
      child: _container(list, context, msg),
    );
  }

  Widget _container(List<Task> list, BuildContext context, Messages msg) {
    if (list.isEmpty) {
      return Container(
          width: 300.0,
          height: 150.0,
          child: Text(msg.noTask,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              )));
    } else {
      return Container(
        width: 200.0,
        height: 200.0,
        child: Column(children: <Widget>[
          Center(
            child: Image.asset(
              'image/all_done.png',
              width: 120,
              height: 120,
            ),
          ),
          Center(
            child: Text(
              msg.noTaskForToday,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ]),
      );
    }
  }
}
