import 'package:ROOTINE/Database.dart';
import 'package:ROOTINE/models/task_model.dart';

class TaskRepository {
  final taskDB = DBProvider();

  Future getAllTodos() => taskDB.getAllTasks();

  Future insertTodo(Task task) => taskDB.newTask(task);
  Future insertNotification(Task task) =>
      PushNotification(task: task).initializing();

  Future updateTodo(Task task) => taskDB.updateTask(task);

  Future deleteTodoById(int id) => taskDB.deleteTask(id);
}
