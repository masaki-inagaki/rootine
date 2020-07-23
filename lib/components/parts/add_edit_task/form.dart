import 'package:flutter/material.dart';
import 'package:ROOTINE/components/parts/misc/datetime.dart';
import 'package:ROOTINE/components/parts/add_edit_task/select_time.dart';
import 'package:intl/intl.dart';

Widget titleForm(TextEditingController controller) {
  return new TextFormField(
    controller: controller,
    enabled: true,
    maxLength: 40,
    maxLengthEnforced: true,
    autovalidate: false,
    autofocus: true,
    keyboardType: TextInputType.text,
    decoration: const InputDecoration(
        hintText: 'Input task title', labelText: 'Task Title'),
    validator: (String value) {
      return value.isEmpty ? 'Mandatory field' : null;
    },
  );
}

Widget intervalForm(TextEditingController controller) {
  return new TextFormField(
    controller: controller,
    enabled: true,
    maxLength: 3,
    maxLengthEnforced: true,
    autovalidate: false,
    autofocus: false,
    keyboardType: TextInputType.number,
    decoration: const InputDecoration(
        hintText: '1 ~ 999', labelText: 'Interval Day(s)'),
    validator: (input) {
      return _intervalFormValidator(input);
    },
  );
}

String _intervalFormValidator(input) {
  final isDigitsOnly = int.tryParse(input);
  if (input.isEmpty) {
    return 'Mandatory field';
  } else if (isDigitsOnly == null) {
    return 'Digits only';
  } else if (int.parse(input) == 0) {
    return '1 ~ 999';
  } else {
    return null;
  }
}

Widget timeForm(
    BuildContext context, TextEditingController controller, bool useTime) {
  return new TextFormField(
    controller: controller,
    enabled: useTime,
    maxLength: 5,
    maxLengthEnforced: true,
    autovalidate: false,
    autofocus: false,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: 'Notice Time',
        hintText: '00:00',
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
        return 'Digits and colon only';
      }
      return timeValidator(time) ? null : "Input time is wrong";
    },
  );
}

Widget firstNoticeDate(
    BuildContext context, bool existing, TextEditingController controller) {
  List<String> noticeDayTitle = ["First Notice Date", 'Next Notice Date'];
  return new TextFormField(
    controller: controller,
    enabled: true,
    autovalidate: false,
    autofocus: false,
    decoration: InputDecoration(
        labelText: noticeDayTitle[existing ? 1 : 0],
        hintText: 'Tap calendar icon',
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
        return 'Incorrect date';
      } else {
        return null;
      }
    },
  );
}
