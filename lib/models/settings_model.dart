import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ROOTINE/repositories/task_repository.dart';

Settings clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Settings.fromMap(jsonData);
}

String clientToJson(Settings data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Settings with ChangeNotifier {
  String item;
  String value;

  Settings({
    this.item,
    this.value,
  });

  final TaskRepository repo = TaskRepository();

  factory Settings.fromMap(Map<String, dynamic> json) => new Settings(
        item: json["item"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "item": item,
        "value": value,
      };

  void update(Settings settings, BuildContext context) async {
    await repo.updateSettings(settings);
  }
}
