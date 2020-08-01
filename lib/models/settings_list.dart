import 'package:flutter/material.dart';
import 'package:ROOTINE/models/settings_model.dart';
import 'package:ROOTINE/repositories/task_repository.dart';
// import 'package:ROOTINE/components/parts/push_notification.dart';

class SettingsList extends ChangeNotifier {
  Settings _languageSettings;
  Settings _noticeTimeSettings;
  List<Settings> _list;
  List<Settings> get list => _list;
  Settings get languageSettings => _languageSettings;
  Settings get noticeTimeSettings => _noticeTimeSettings;

  final TaskRepository repo = TaskRepository();

  SettingsList() {
    _fetchAll();
  }

  void _fetchAll() async {
    _languageSettings = await repo.getSettings('language');
    _noticeTimeSettings = await repo.getSettings('notice_time');
    // List<Settings> _list = await repo.getAllSettings();
    // _languageSettings = _list[0];
    // _noticeTimeSettings = _list[1];
    notifyListeners();
  }

  void update(Settings settings, BuildContext context) async {
    await repo.updateSettings(settings);
    notifyListeners();
  }
}
