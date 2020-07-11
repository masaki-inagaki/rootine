import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';

class TimeDifference extends StatelessWidget {
  final Task task;
  const TimeDifference({
    Key key,
    @required this.task,
  });

  Widget build(BuildContext context) {
    final now = DateTime.now();
    int dueTime;
    String dueTrail;
    Duration diff = task.dueDate.difference(now);

    if (diff.inDays.abs() > 0) {
      dueTime = diff.inDays.abs();
      dueTrail = "d";
      // dueTrail = dueTime > 1 ? " days" : " day";
    } else if (diff.inHours.abs() > 0) {
      dueTime = diff.inHours.abs();
      dueTrail = "h";
      // dueTrail = dueTime > 1 ? " hours" : " hour";
    } else {
      dueTime = diff.inMinutes.abs();
      dueTrail = "m";
      // dueTrail = dueTime > 1 ? " minutes" : " minute";
    }

    if (diff.inSeconds > 0) {
      return Text(
        "Due: " + dueTime.toString() + dueTrail,
        style: TextStyle(color: Colors.blue),
      );
    } else {
      return Text(
        "Overdue: " + dueTime.toString() + dueTrail,
        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
      );
    }
  }
}
