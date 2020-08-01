import 'package:ROOTINE/components/notification_settings.dart';
import 'package:flutter/material.dart';
import 'package:ROOTINE/config/const_text.dart';
import 'package:ROOTINE/language/app_local.dart';
import 'package:ROOTINE/components/language_settings.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/language/messages.dart';
import 'package:ROOTINE/models/settings_list.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sList = context.watch<SettingsList>();
    final currentLang = sList.languageSettings;

    if (currentLang == null) {
      return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
    }

    Messages msg = Lang(lang: currentLang.value).current(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 85,
            child: DrawerHeader(
              child: Text(
                msg.settings['settings'],
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            title: Text(
              msg.settings['language'],
              style: ConstStyle.listFont,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LanguageSettings(),
              ));
            },
          ),
          ListTile(
            title: Text(
              msg.settings['notification'],
              style: ConstStyle.listFont,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NotificationSettings(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
