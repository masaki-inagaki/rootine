import 'package:flutter/material.dart';
import 'package:ROOTINE/language/app_local.dart';
import 'package:ROOTINE/language/messages.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/settings_list.dart';

class AppBarTitle extends StatelessWidget {
  final int i;
  const AppBarTitle({
    Key key,
    @required this.i,
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
    return Text(msg.menuName[i]);
  }
}
