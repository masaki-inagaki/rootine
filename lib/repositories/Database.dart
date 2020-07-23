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
          "day INTEGER,"
          "due_date TEXT,"
          "use_time INTEGER,"
          "notice_time TEXT"
          ")");
    });
  }

  newTask(Task task) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Task");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Task (id,task_name,day,due_date,use_time,notice_time)"
        " VALUES (?,?,?,?,?,?)",
        [
          id,
          task.taskName,
          task.day,
          task.dueDate.toUtc().toIso8601String(),
          task.useTime ? 1 : 0,
          task.noticeTime
        ]);
    return raw;
  }

  updateTask(Task task) async {
    final db = await database;
    var res = await db
        .update("Task", task.toMap(), where: "id = ?", whereArgs: [task.id]);
    return res;
  }

  getTask(int id) async {
    final db = await database;
    var res = await db.query("Task", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Task.fromMap(res.first) : null;
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    var res = await db.query("Task");
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

  deleteTask(int id) async {
    final db = await database;
    return db.delete("Task", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Task");
  }
}
