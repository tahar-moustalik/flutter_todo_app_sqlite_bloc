import '../database/database.dart';
import '../models/Todo.dart';

class TodoDao {
  final dbProvider = DatabaseProvider.databaseProvider;
  Future<int> createTodoInTask(Todo todo) async {
    final db = await dbProvider.database;
    var result = await db.insert(todosTable, todo.toDatabaseJson());
    return result;
  }

  Future<List<Todo>> getTodosOfTask({List<String> columns, int taskId}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;

    result = await db.query(todosTable,
        columns: columns, where: "task_id = ?", whereArgs: [taskId]);

    List<Todo> todos = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
    todos.sort((a, b) => b.done.toString().compareTo(a.done.toString()));
    return todos;
  }

  Future<int> updateTodoInTask(Todo todo) async {
    final db = await dbProvider.database;
    var result = await db.update(todosTable, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodoInTask(int id) async {
    var db = await dbProvider.database;
    var result = await db.delete(todosTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }
}
