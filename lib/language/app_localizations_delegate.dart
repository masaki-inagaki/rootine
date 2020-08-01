import 'package:flutter/material.dart';
import 'package:ROOTINE/language/app_local.dart';

class AppLocalDelegate extends LocalizationsDelegate<AppLocal> {
  const AppLocalDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<AppLocal> load(Locale locale) async => AppLocal(locale);

  @override
  bool shouldReload(AppLocalDelegate old) => false;
}
