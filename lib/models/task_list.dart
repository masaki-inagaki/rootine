import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/repositories/task_repository.dart';
import 'package:ROOTINE/components/parts/push_notification.dart';
import 'package:ROOTINE/language/messages.dart';

class TaskList with ChangeNotifier {
  List<Task> _allTaskList = [];
  List<Task> _currentList = [];
  List<Task> get allTaskList => _allTaskList;
  List<Task> get currentList => _currentList;

  final TaskRepository repo = TaskRepository();

  TaskList() {
    _fetchAll();
  }

  void _fetchAll() async {
    _allTaskList = await repo.getAllTodos();
    _currentList = await _filterDue();
    notifyListeners();
  }

  Future<List<Task>> _filterDue() async {
    var now = DateTime.now();
    List<Task> _list = [];
    for (var task in _allTaskList) {
      Duration diff = task.dueDate.difference(now);
      if (diff.inHours <= 25) {
        _list.add(task);
      }
    }
    return _list;
  }

  void add(Task task, BuildContext context, Messages msg) async {
    task.id = await repo.insertTodo(task);
    _fetchAll();
    PushNotification(task: task).initializing(context, msg);
  }

  void update(Task task, BuildContext context, Messages msg) async {
    await repo.updateTodo(task);
    _fetchAll();
    PushNotification(task: task).deleting();
    PushNotification(task: task).initializing(context, msg);
  }

  // void toggleIsDone(Client task) async {
  //   task.isDone = !task.isDone;
  //   update(task);
  // }

  Future remove(Task task) async {
    await repo.deleteTodoById(task.id);
    _fetchAll();
    PushNotification(task: task).deleting();
  }
}
