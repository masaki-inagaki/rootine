import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/repositories/task_repository.dart';

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
      Duration diff =
          task.dueDate.difference(DateTime(now.year, now.month, now.day));
      if (diff.inDays <= 2) {
        _list.add(task);
      }
    }
    return _list;
  }

  void add(Task task) async {
    await repo.insertTodo(task);
    _fetchAll();
  }

  void update(Task task) async {
    await repo.updateTodo(task);
    _fetchAll();
  }

  // void toggleIsDone(Client task) async {
  //   task.isDone = !task.isDone;
  //   update(task);
  // }

  void remove(Task task) async {
    await repo.deleteTodoById(task.id);
    _fetchAll();
  }
}
