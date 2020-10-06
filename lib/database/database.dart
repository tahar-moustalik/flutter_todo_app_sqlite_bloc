import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final tasksTABLE = 'Tasks';
final todosTable = 'Todos';

class DatabaseProvider {
  // this is our singleton of database
  static final DatabaseProvider databaseProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'fireTasks.db');
    var database = await openDatabase(path,
        version: 1,
        onCreate: initDB,
        onUpgrade: onUpgrade,
        onConfigure: onConfigure);

    return database;
  }

  void onUpgrade(Database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $tasksTABLE ("
        "id INTEGER PRIMARY KEY, "
        "title TEXT, "
        "tagColor TEXT)");
    await database.execute("CREATE TABLE $todosTable ("
        "id INTEGER PRIMARY KEY, "
        "text TEXT, "
        "done INTEGER, "
        "task_id INTEGER, "
        "FOREIGN KEY (task_id) REFERENCES $tasksTABLE (id) ON DELETE NO ACTION ON UPDATE NO ACTION)");

  }

  static Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
