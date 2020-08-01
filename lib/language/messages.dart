import 'package:flutter/material.dart';
import 'package:ROOTINE/components/parts/misc/datetime.dart';
// import 'package:ROOTINE/models/settings_list.dart';
// import 'package:ROOTINE/models/settings_model.dart';
import 'package:intl/intl.dart';

class Messages {
  Messages({
    @required this.addTask,
    @required this.menuName,
    @required this.noTask,
    @required this.noTaskForToday,
    @required this.newTask,
    @required this.slidable,
    @required this.snackbar,
    @required this.postpone,
    @required this.settings,
    @required this.notification,
    @required this.dueTime,
  });

  final String addTask;
  final List<String> menuName;
  final String noTask;
  final String noTaskForToday;
  final Map newTask;
  final Map slidable;
  final Map snackbar;
  final Map postpone;
  final Map settings;
  final Map notification;
  final Map dueTime;

  factory Messages.of(Locale locale) {
    switch (locale.languageCode) {
      case 'ja':
        return Messages.ja();
      case 'en':
        return Messages.en();
      default:
        return Messages.en();
    }
  }

  factory Messages.lang(String lang) {
    switch (lang.toString()) {
      case 'japanese':
        return Messages.ja();
      case 'english':
        return Messages.en();
      default:
        return Messages.en();
    }
  }

  factory Messages.ja() => Messages(
      //BottomNavigation
      menuName: ["現在のタスク", "全てのタスク"],
      //New task floationg button
      addTask: "新しいタスク",
      //empty screen
      noTask: "まだタスクがありません。\n「新しいタスク」ボタンから、最初のタスクを登録しましょう",
      noTaskForToday: '現在のタスクはありません。\n素晴らしいです！',
      //New Task Screen
      newTask: {
        'taskTitle': 'タスク名',
        'taskTitleHint': 'タスク名を入力してください',
        'intervalDays': '通知間隔(何日ごと)',
        'intervalDaysHint': '1〜999',
        'showOptions': 'オプションを表示',
        'hideOptions': 'オプションを隠す',
        'useNoticeTime': '通知時間の指定',
        'noticeTime': '通知時間',
        'noticeTimeHint': '00:00',
        'tapCalendar': 'カレンダーをタップ',
        'firstNoticeDate': '最初の通知日を指定',
        'nextNoticeDate': '次回の通知日を指定',
        'cancel': 'キャンセル',
        'add': '追加',
        'done': '完了',
        'addANewTask': '新しいタスクの作成',
        'edit': '編集',
        'mandatory': '必須項目です。',
        'digitsOnly': '数字のみ入力可',
        'digitsColonOnly': '数字とコロンのみ入力可',
        'wrongTime': '入力時刻に誤りがあります',
        'wrongDate': '日付に誤りがあります',
      },
      //All tasks screen
      slidable: {
        'interval': '通知間隔',
        'day': (day) {
          return '$day 日ごと';
        },
        'nextDueDate': '次回通知日',
        'dueDate': (date) {
          return DateFormat('yyyy/MM/dd').format(date);
        },
        'noticeTime': '通知時間',
        'disabled': '指定なし',
        'edit': '編集',
        'delete': '削除',
      },
      snackbar: {
        'newTask': (DateTime day) {
          final String date = DateFormat('M月d日').format(day);
          return 'タスクを追加しました。' + date + 'にお知らせします。';
        },
        'wellDone': (int day) {
          return '素晴らしいです!! また' + day.toString() + '日後にお知らせします。';
        },
        'undo': '元に戻す',
        'delete': (String task) {
          return 'タスク「' + task + '」を削除しました。';
        },
        'edited': (DateTime date) {
          final String dateString = DateFormat('M月d日').format(date);
          return 'タスクが変更されました。次回は、' + dateString + 'にお知らせします。';
        }
      },
      postpone: {
        'alertMessage': 'タスクを延長しますか?',
        'cancel': 'キャンセル',
        'tomorrow': '明日',
        'pickTimeDate': '日時を指定',
        'done': '完了',
      },
      settings: {
        'settings': '設定',
        'language': '言語設定',
        'notification': '通知設定',
        'notificationSettings': '通知設定',
        'noticeTime': '通知時間',
        'noticeTimeHint': '09:00',
        'save': '保存',
        'cancel': 'キャンセル',
      },
      notification: {
        'overdue': 'タスク通知: ',
        'overdueMessage': 'さあ、タスクを完了しましょう。',
      },
      dueTime: {
        'd': '日',
        'h': '時間',
        'm': '分',
        'day': '日',
        'days': '日',
        'hour': '時間',
        'houts': '時間',
        'minute': '分',
        'minutes': '分',
        'due': '期限: ',
        'overdue': '超過: ',
      });

  factory Messages.en() => Messages(
        //BottomNavigation
        menuName: ["Todo: Now", "All Tasks"],
        //New task floationg button
        addTask: "Add a new task",
        //empty screen
        noTask:
            "You have no task now.\nClick the button below to add your first task",
        noTaskForToday: 'Well done!!\nYou have no task for now.',
        newTask: {
          'taskTitle': 'Task Title',
          'taskTitleHint': 'Input task title',
          'intervalDays': 'Interval Days',
          'intervalDaysHint': '1〜999',
          'showOptions': 'Show options',
          'hideOptions': 'Hide options',
          'useNoticeTime': 'Use notice time',
          'noticeTime': 'Notice time',
          'noticeTimeHint': '00:00',
          'tapCalendar': 'Tap calendar icon',
          'firstNoticeDate': 'First notice date',
          'nextNoticeDate': 'Next notice date',
          'cancel': 'Cancel',
          'add': 'Add',
          'done': 'Done',
          'addANewTask': 'Add a new task',
          'edit': 'Edit',
          'mandatory': 'This field is mandatory',
          'digitsOnly': 'Digits only',
          'digitsColonOnly': 'Digits and colon only',
          'wrongTime': 'Input time is wrong',
          'wrongDate': 'Input date is wrong',
        },
        slidable: {
          'interval': 'Interval days',
          'day': (day) {
            return intToDays(day);
          },
          'nextDueDate': 'Next due date',
          'dueDate': (date) {
            final String suffix = dateSuffix(date);
            return DateFormat('MMM d').format(date) + suffix;
          },
          'noticeTime': 'Notice time',
          'disabled': 'Disabled',
          'edit': 'Edit',
          'delete': 'Delete',
        },
        snackbar: {
          'newTask': (day) {
            final String date = DateFormat('MMM d').format(day);
            final String suffix = dateSuffix(day);
            return 'Task added, will notify you on ' + date + suffix;
          },
          'wellDone': (int day) {
            return 'Well done!! Reminds you again after ' + intToDays(day);
          },
          'undo': 'Undo',
          'delete': (String task) {
            return 'Deleted the task: ' + task;
          },
          'edited': (DateTime date) {
            final String dateString = DateFormat('MMM d').format(date);
            final String suffix = dateSuffix(date);
            return 'Task edited, will notify you on ' + dateString + suffix;
          }
        },
        postpone: {
          'alertMessage': 'Postpone the task?',
          'cancel': 'Cancel',
          'tomorrow': 'Tomorrow',
          'pickTimeDate': 'Pick time and date',
          'done': 'Done',
        },
        settings: {
          'settings': 'Settings',
          'language': 'Language Settings',
          'notification': 'Notification',
          'notificationSettings': 'Notification Settings',
          'noticeTime': 'Notice Time',
          'noticeTimeHint': '09:00',
          'save': 'Save',
          'cancel': 'Cancel',
        },
        notification: {
          'overdue': 'Task notification: ',
          'overdueMessage': "Now let's complete the task!",
        },
        dueTime: {
          'd': 'd',
          'h': 'h',
          'm': 'm',
          'day': 'day',
          'days': 'days',
          'hour': 'hour',
          'houts': 'hours',
          'minute': 'min',
          'minutes': 'minutes',
          'due': 'Due: ',
          'overdue': 'Overdue: ',
        },
      );
}
