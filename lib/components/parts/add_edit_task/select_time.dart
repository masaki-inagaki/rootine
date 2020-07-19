import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<DateTime> selectDate(BuildContext context) async {
  final DateTime dt = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(new Duration(days: 365)),
  );
  if (dt != null) {
    return dt;
  } else {
    return null;
  }
}

Future<String> selectTime(BuildContext context) async {
  final TimeOfDay t = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (t != null) {
    var dt = toDateTime(t);
    return DateFormat.Hm().format(dt);
  } else {
    return null;
  }
}

DateTime toDateTime(TimeOfDay t) {
  var now = DateTime.now();
  return DateTime(now.year, now.month, now.day, t.hour, t.minute);
}
