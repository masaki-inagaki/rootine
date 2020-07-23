import 'dart:convert';

import 'package:flutter/material.dart';

Task clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Task.fromMap(jsonData);
}

String clientToJson(Task data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Task with ChangeNotifier {
  int id;
  String taskName;
  int day;
  DateTime dueDate;
  bool useTime;
  String noticeTime;

  Task(
      {this.id,
      this.taskName,
      this.day,
      this.dueDate,
      this.useTime,
      this.noticeTime});

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json["id"],
        taskName: json["task_name"],
        day: json["day"],
        dueDate: DateTime.parse(json["due_date"]).toLocal(),
        useTime: json["use_time"] == 1,
        noticeTime: json["notice_time"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "task_name": taskName,
        "day": day,
        "due_date": dueDate.toUtc().toIso8601String(),
        "use_time": useTime ? 1 : 0,
        "notice_time": noticeTime,
      };
}
