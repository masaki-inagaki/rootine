import 'package:flutter/material.dart';
import 'package:ROOTINE/components/parts/all_tasks/edit_task_details.dart';
import 'package:ROOTINE/language/app_local.dart';
import 'package:ROOTINE/models/settings_list.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/language/messages.dart';

class AddNewTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sList = context.watch<SettingsList>();
    final currentLang = sList.languageSettings;

    if (currentLang == null) {
      return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
    }

    Messages msg = Lang(lang: currentLang.value).current(context);

    return FloatingActionButton.extended(
      icon: Icon(Icons.add_box),
      label: Text(msg.addTask),
      onPressed: () async {
        final date = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditTaskDetails(),
          ),
        );
        if (date != null && date != 'Cancel') {
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(msg.snackbar['newTask'](date))));
        }
      },
    );
  }
}
