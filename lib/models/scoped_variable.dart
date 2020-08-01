import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class ScopedVariableModel extends Model {
  String _lang = "";
  String _globalNoticeTime = "";

  String get lang {
    return _lang;
  }

  String get globalNoticeTime {
    return _globalNoticeTime;
  }

  void updateLang(String lang) {
    _lang = lang;
    notifyListeners();
  }

  void updateGlobalNoticeTime(String time) {
    _globalNoticeTime = time;
    notifyListeners();
  }

  static ScopedVariableModel of(BuildContext context) =>
      ScopedModel.of<ScopedVariableModel>(context);
}
