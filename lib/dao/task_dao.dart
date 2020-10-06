import '../database/database.dart';
import '../models/Task.dart';

class TaskDao {
  final dbProvider = DatabaseProvider.databaseProvider;
  Future<int> createTask(Task task) async {
    final db = await dbProvider.database;
    var result = await db.insert(tasksTABLE, task.toDatabaseJson());
    return result;
  }

  Future<List<Task>> getTasks({List<String> columns}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;

    result = await db.query(tasksTABLE, columns: columns);

    List<Task> tasks = result.isNotEmpty
        ? result.map((item) {
            return Task.fromDatabaseJson(item);
          }).toList()
        : [];
    tasks.sort((a, b) => b.id.toString().compareTo(a.id.toString()));
    return tasks;
  }

  Future deleteTask(int taskId) async {
    final db = await dbProvider.database;
    final resDeletingAsocTodos =
        await db.delete(todosTable, where: "task_id = ?", whereArgs: [taskId]);
    final res =
        await db.delete(tasksTABLE, where: "id = ?", whereArgs: [taskId]);
    return res;
  }

  Future deleteAllTasks() async {
    final db = await dbProvider.database;
    var resDelTodo = await db.delete(todosTable);
    var result = await db.delete(
      tasksTABLE,
    );

    return result;
  }
}
