import 'package:ROOTINE/Database.dart';
import 'package:ROOTINE/models/task_model.dart';

class TaskRepository {
  final taskDB = DBProvider();

  Future getAllTodos() => taskDB.getAllClients();

  Future insertTodo(Task task) => taskDB.newClient(task);

  Future updateTodo(Task task) => taskDB.updateClient(task);

  Future deleteTodoById(int id) => taskDB.deleteClient(id);
}
