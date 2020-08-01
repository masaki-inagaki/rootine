import 'package:ROOTINE/repositories/Database.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:ROOTINE/models/settings_model.dart';

class TaskRepository {
  final db = DBProvider();

  Future getAllTodos() => db.getAllTasks();

  Future insertTodo(Task task) {
    final id = db.newTask(task);
    return id;
  }

  Future updateTodo(Task task) => db.updateTask(task);

  Future deleteTodoById(int id) => db.deleteTask(id);

  Future updateSettings(Settings settings) => db.updateSettings(settings);

  Future getSettings(String item) => db.getSettings(item);

  Future getAllSettings() => db.getAllSettings();
}
