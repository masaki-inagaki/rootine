import 'package:flutter/material.dart';
import 'package:ROOTINE/language/messages.dart';

class Lang {
  final String lang;
  const Lang({
    @required this.lang,
  });

  Messages current(BuildContext context) {
    if (lang == '') {
      return AppLocal.of(context);
    } else {
      switch (lang) {
        case 'japanese':
          return Messages.ja();
        case 'english':
          return Messages.en();
        default:
          return Messages.en();
      }
    }
  }
}

class AppLocal {
  final Messages messages;

  AppLocal(Locale locale) : this.messages = Messages.of(locale);

  static Messages of(BuildContext context) {
    return Localizations.of<AppLocal>(context, AppLocal).messages;
  }
}
