import 'package:ROOTINE/models/settings_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/components/parts/misc/datetime.dart';
import 'package:ROOTINE/components/parts/add_edit_task/select_time.dart';
import 'package:ROOTINE/models/settings_model.dart';
import 'package:ROOTINE/language/app_local.dart';
import 'package:ROOTINE/language/messages.dart';

class NotificationSettings extends StatefulWidget {
  NotificationSettings({
    Key key,
  }) : super(key: key);
  @override
  NotificationSettingsState createState() => new NotificationSettingsState();
}

class NotificationSettingsState extends State<NotificationSettings> {
  final timeTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Settings lang;
  SettingsList sList;

  @override
  void initState() {
    super.initState();
    // if (sList.noticeTimeSettings.value != '') {
    //   timeTextController.text = sList.noticeTimeSettings.value;
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void wait() async {
    await Future.delayed(Duration(milliseconds: 200));
  }

  @override
  build(BuildContext context) {
    sList = context.watch<SettingsList>();
    final currentLang = sList.languageSettings;

    if (currentLang == null) {
      return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
    }

    Messages msg = Lang(lang: currentLang.value).current(context);

    wait();

    if (sList.noticeTimeSettings.value != '') {
      timeTextController.text = sList.noticeTimeSettings.value;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          msg.settings['notificationSettings'],
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _timeForm(timeTextController, context, msg),
                _buttonArea(context, sList, msg),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timeForm(
      TextEditingController controller, BuildContext context, Messages msg) {
    //controller.text = sList.noticeTimeSettings.value;
    return new TextFormField(
      controller: controller,
      maxLength: 5,
      maxLengthEnforced: true,
      autovalidateMode: AutovalidateMode.always,
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: msg.settings['noticeTime'],
          hintText: msg.settings['noticeTimeHint'],
          suffixIcon: IconButton(
            icon: Icon(Icons.timer),
            onPressed: () async {
              var time = await selectTime(context);
              if (time != null) {
                controller.text = time.toString();
              }
            },
          )),
      validator: (input) {
        if (input.isEmpty || input == null) {
          return msg.newTask['mandatory'];
        }
        final String time = input.replaceAll(':', '');
        if (int.tryParse(time) == null) {
          return msg.newTask['digitsColonOnly'];
        }
        return timeValidator(time) ? null : msg.newTask['wrongTime'];
      },
    );
  }

  Widget _buttonArea(BuildContext context, SettingsList sList, Messages msg) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 200,
          child: Row(
            children: <Widget>[
              Container(
                width: 90,
                height: 50,
                margin: const EdgeInsets.only(top: 5.0),
                child: FlatButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: Text(msg.settings['cancel'])),
              ),
              Container(
                  width: 90,
                  height: 50,
                  margin: const EdgeInsets.only(top: 5.0),
                  child: FlatButton(
                      color: Colors.blue,
                      textTheme: ButtonTextTheme.primary,
                      onPressed: () {
                        _saveTask(context, sList);
                        Navigator.pop(context, 'Save');
                      },
                      child: Text(msg.settings['save']))),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTask(BuildContext context, SettingsList sList) {
    if (timeTextController.text != null &&
        timeTextController.text.isEmpty == false) {
      final settings = new Settings();
      settings.item = 'notice_time';
      settings.value = timeTextController.text;
      sList.update(settings, context);
    }
  }
}
