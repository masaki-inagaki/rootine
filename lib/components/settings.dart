import 'package:flutter/material.dart';
import 'package:ROOTINE/config/const_text.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 75,
            child: DrawerHeader(
              child: Text(
                'Settings',
                style: ConstStyle.listFont,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Language',
              style: ConstStyle.listFont,
            ),
            onTap: () {
              // Update the state of the app.
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Notification',
              style: ConstStyle.listFont,
            ),
            onTap: () {
              // Update the state of the app.
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
