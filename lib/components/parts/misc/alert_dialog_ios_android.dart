import 'package:flutter/material.dart';

class AlertDialogIOSAndroid extends StatelessWidget {
  final Text title;
  final Text content;
  final Text yes;
  const AlertDialogIOSAndroid({
    Key key,
    @required this.title,
    @required this.content,
    @required this.yes,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context, null),
        ),
        FlatButton(
            child: yes,
            color: Colors.blue,
            textTheme: ButtonTextTheme.primary,
            onPressed: () {
              return(true);
            })
      ],
    );
  }
}
