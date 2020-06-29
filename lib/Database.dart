import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ROOTINE/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  DBProvider();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Task ("
          "id INTEGER PRIMARY KEY,"
          "task_name TEXT,"
          "blocked BIT"
          ")");
    });
  }

  newClient(Task newClient) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Task");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Task (id,task_name,blocked)"
        " VALUES (?,?,?)",
        [id, newClient.taskName, newClient.blocked]);
    return raw;
  }

  blockOrUnblock(Task task) async {
    final db = await database;
    Task blocked =
        Task(id: task.id, taskName: task.taskName, blocked: !task.blocked);
    var res = await db
        .update("Task", blocked.toMap(), where: "id = ?", whereArgs: [task.id]);
    return res;
  }

  updateClient(Task newClient) async {
    final db = await database;
    var res = await db.update("Task", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Task", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Task.fromMap(res.first) : null;
  }

  Future<List<Task>> getBlockedClients() async {
    final db = await database;
    var res = await db.query("Task", where: "blocked = ? ", whereArgs: [1]);

    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Task>> getAllClients() async {
    final db = await database;
    var res = await db.query("Task");
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete("Task", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Task");
  }
}
