import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ROOTINE/language/messages.dart';
//import 'package:path/path.dart';

class PushNotification {
  final Task task;
  const PushNotification({
    Key key,
    @required this.task,
  });

  void initializing(BuildContext context, Messages msg) {
    _showNotification(task, context, msg);
  }

  Future _showNotification(
      Task task, BuildContext context, Messages msg) async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    var time = task.dueDate;
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      task.id,
      msg.notification['overdue'] + ': ' + task.taskName,
      msg.notification['overdueMessage'],
      time,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  void deleting() {
    _deleteNotification(task);
  }

  Future _deleteNotification(Task task) async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin.cancel(task.id);
  }
}
