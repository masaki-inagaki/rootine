import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';

class TimeDifference {
  final Task task;
  TimeDifference({
    Key key,
    @required this.task,
  });

  List process(String type) {
    int dueTime;
    String dueTrail;
    String postponeTrail;
    Duration diff = task.dueDate.difference(DateTime.now());
    bool due;

    due = diff.inSeconds > 0 ? true : false;

    if (diff.inDays.abs() > 0) {
      dueTime = diff.inDays.abs();
      dueTrail = "d";
      postponeTrail = dueTime > 1 ? " days" : " day";
    } else if (diff.inHours.abs() > 0) {
      dueTime = diff.inHours.abs();
      dueTrail = "h";
      postponeTrail = dueTime > 1 ? " hours" : " hour";
    } else {
      dueTime = diff.inMinutes.abs();
      dueTrail = "m";
      postponeTrail = dueTime > 1 ? " minutes" : " minute";
    }

    if (type == "due") {
      return [dueTime.toString(), dueTrail, due];
    }
    return [dueTime.toString(), postponeTrail, due];
  }

  List due() {
    return process("due");
  }

  String postpone() {
    return process("postpone")[0];
  }
}
