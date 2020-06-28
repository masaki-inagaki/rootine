import 'package:flutter/material.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/repositories/task_repository.dart';

class TaskList with ChangeNotifier{  
  List<Client> _allTodoList = [];
  List<Client> get currentList => _allTodoList;
  List<Client> get allTaskList => _allTodoList;
  
  final TaskRepository repo = TaskRepository();

  TaskList(){
    _fetchAll();
  }

  void _fetchAll() async {
    _allTodoList = await repo.getAllTodos();
    notifyListeners();
  }

  void add(Client task) async {
    await repo.insertTodo(task);
    _fetchAll();
    notifyListeners();
  }

  void update(Client task) async {
    await repo.updateTodo(task);
    _fetchAll();
    notifyListeners();
  }

  // void toggleIsDone(Client task) async {
  //   task.isDone = !task.isDone;
  //   update(task);
  // }

  void remove(Client task) async {
    await repo.deleteTodoById(task.id);
    _fetchAll();
  }

}