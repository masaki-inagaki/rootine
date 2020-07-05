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
  bool blocked;
  int day;
  DateTime dueDate;

  Task({this.id, this.taskName, this.blocked, this.day, this.dueDate});

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json["id"],
        taskName: json["task_name"],
        blocked: json["blocked"] == 1,
        day: json["day"],
        dueDate: DateTime.parse(json["due_date"]).toLocal(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "task_name": taskName,
        "blocked": blocked,
        "day": day,
        "due_date": dueDate.toUtc().toIso8601String(),
      };
}
