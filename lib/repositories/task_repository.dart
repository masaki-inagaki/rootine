import 'package:ROOTINE/repositories/Database.dart';
import 'package:ROOTINE/models/task_model.dart';

class TaskRepository {
  final taskDB = DBProvider();

  Future getAllTodos() => taskDB.getAllTasks();

  Future insertTodo(Task task) {
    final id = taskDB.newTask(task);
    return id;
  }

  Future updateTodo(Task task) => taskDB.updateTask(task);

  Future deleteTodoById(int id) => taskDB.deleteTask(id);
}
