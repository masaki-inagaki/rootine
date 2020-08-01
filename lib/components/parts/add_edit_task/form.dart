import 'package:flutter/material.dart';
import 'package:ROOTINE/components/parts/misc/datetime.dart';
import 'package:ROOTINE/components/parts/add_edit_task/select_time.dart';
import 'package:intl/intl.dart';
import 'package:ROOTINE/language/app_local.dart';
import 'package:ROOTINE/language/messages.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/settings_list.dart';

Widget titleForm(TextEditingController controller, BuildContext context) {
  final sList = context.watch<SettingsList>();
  final currentLang = sList.languageSettings;

  if (currentLang == null) {
    return CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
  }

  Messages msg = Lang(lang: currentLang.value).current(context);
  return new TextFormField(
    controller: controller,
    enabled: true,
    maxLength: 40,
    maxLengthEnforced: true,
    autovalidate: false,
    autofocus: true,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
        hintText: msg.newTask['taskTitleHint'],
        labelText: msg.newTask['taskTitle']),
    validator: (String value) {
      return value.isEmpty ? msg.newTask['mandatory'] : null;
    },
  );
}

Widget intervalForm(
    TextEditingController controller, BuildContext context, Messages msg) {
  return new TextFormField(
    controller: controller,
    enabled: true,
    maxLength: 3,
    maxLengthEnforced: true,
    autovalidate: false,
    autofocus: false,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        hintText: msg.newTask['intervalDaysHint'],
        labelText: msg.newTask['intervalDays']),
    validator: (input) {
      return _intervalFormValidator(input, context, msg);
    },
  );
}

String _intervalFormValidator(input, BuildContext context, Messages msg) {
  final isDigitsOnly = int.tryParse(input);
  if (input.isEmpty) {
    return msg.newTask['mandatory'];
  } else if (isDigitsOnly == null) {
    return msg.newTask['digitsOnly'];
  } else if (int.parse(input) == 0) {
    return msg.newTask['intervalDaysHint'];
  } else {
    return null;
  }
}

Widget timeForm(BuildContext context, TextEditingController controller,
    bool useTime, Messages msg) {
  return new TextFormField(
    controller: controller,
    enabled: useTime,
    maxLength: 5,
    maxLengthEnforced: true,
    autovalidate: false,
    autofocus: false,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: msg.newTask['noticeTime'],
        hintText: msg.newTask['noticeTimeHint'],
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
      if (input.isEmpty) {
        return null;
      }
      final String time = input.replaceAll(':', '');
      if (int.tryParse(time) == null) {
        return msg.newTask['digitsColonOnly'];
      }
      return timeValidator(time) ? null : msg.newTask['wrongTime'];
    },
  );
}

Widget firstNoticeDate(
    BuildContext context, bool existing, TextEditingController controller) {
  final sList = context.watch<SettingsList>();
  final currentLang = sList.languageSettings;

  if (currentLang == null) {
    return CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
  }
  Messages msg = Lang(lang: currentLang.value).current(context);

  List<String> noticeDayTitle = [
    msg.newTask['firstNoticeDate'],
    msg.newTask['nextNoticeDate']
  ];
  return new TextFormField(
    controller: controller,
    enabled: true,
    autovalidate: false,
    autofocus: false,
    decoration: InputDecoration(
        labelText: noticeDayTitle[existing ? 1 : 0],
        hintText: msg.newTask['tapCalendar'],
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () async {
            final DateTime firstDay = await selectDate(context);
            if (firstDay != null) {
              final DateFormat df = new DateFormat('yyyy-MM-dd');
              controller.text = df.format(firstDay);
            }
          },
        )),
    validator: (input) {
      if (input.isEmpty) {
        return null;
      } else if (DateTime.tryParse(input) == null) {
        return msg.newTask['wrongDate'];
      } else {
        return null;
      }
    },
  );
}
