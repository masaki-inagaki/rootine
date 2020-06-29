import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/repositories/task_repository.dart';

class TaskList with ChangeNotifier {
  List<Task> _allTodoList = [];
  List<Task> get currentList => _allTodoList;
  List<Task> get allTaskList => _allTodoList;

  final TaskRepository repo = TaskRepository();

  TaskList() {
    _fetchAll();
  }

  void _fetchAll() async {
    _allTodoList = await repo.getAllTodos();
    notifyListeners();
  }

  void add(Task task) async {
    await repo.insertTodo(task);
    _fetchAll();
    notifyListeners();
  }

  void update(Task task) async {
    await repo.updateTodo(task);
    _fetchAll();
    notifyListeners();
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
