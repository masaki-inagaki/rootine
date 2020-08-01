import 'package:ROOTINE/models/settings_list.dart';
import 'package:flutter/material.dart';
import 'package:ROOTINE/language/app_local.dart';
import 'package:ROOTINE/config/const_text.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/language/messages.dart';

class LanguageSettings extends StatelessWidget {
  final List<Map> lang = [
    {'lang': 'English', 'db': 'english'},
    {'lang': 'Japanese(日本語)', 'db': 'japanese'}
  ];

  @override
  Widget build(BuildContext context) {
    final sList = context.watch<SettingsList>();
    final currentLang = sList.languageSettings;

    if (currentLang == null) {
      return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
    }

    Messages msg = Lang(lang: currentLang.value).current(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          msg.settings['language'],
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
            top: 4.0, left: 4.0, right: 4.0, bottom: 75.0),
        itemCount: lang.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12),
              ),
            ),
            child: ListTile(
              title: Text(
                lang[i]['lang'],
                style: ConstStyle.listFont,
              ),
              trailing:
                  lang[i]['db'] == currentLang.value ? Icon(Icons.check) : null,
              onTap: () {
                currentLang.value = lang[i]['db'];
                sList.update(currentLang, context);
              },
            ),
          );
        },
      ),
    );
  }
}
