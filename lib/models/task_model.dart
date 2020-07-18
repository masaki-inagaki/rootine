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
  bool useTime;
  int day;
  DateTime dueDate;
  String noticeTime;

  Task(
      {this.id,
      this.taskName,
      this.useTime,
      this.day,
      this.dueDate,
      this.noticeTime});

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json["id"],
        taskName: json["task_name"],
        useTime: json["use_time"] == 1,
        day: json["day"],
        dueDate: DateTime.parse(json["due_date"]).toLocal(),
        noticeTime: json["notice_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "task_name": taskName,
        "use_time": useTime,
        "day": day,
        "due_date": dueDate.toUtc().toIso8601String(),
        "notice_time": noticeTime,
      };
}
