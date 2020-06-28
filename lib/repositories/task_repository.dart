import 'package:ROOTINE/Database.dart';
import 'package:ROOTINE/models/task_model.dart';

class TaskRepository {
  final taskDB = DBProvider();

  Future getAllTodos() => taskDB.getAllClients();

  Future insertTodo(Client task) => taskDB.newClient(task);

  Future updateTodo(Client task) => taskDB.updateClient(task);

  Future deleteTodoById(int id) => taskDB.deleteClient(id);
}
