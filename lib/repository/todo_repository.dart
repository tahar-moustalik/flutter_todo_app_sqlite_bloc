import '../dao/todo_dao.dart';
import '../models/Todo.dart';

class TodoRepository {
  final todoDao = TodoDao();

  Future getAllTodosInTask({List<String> columns, int taskId}) =>
      todoDao.getTodosOfTask(columns: columns, taskId: taskId);
  Future createTodo(Todo todo) => todoDao.createTodoInTask(todo);
  Future updateTodo(Todo todo) => todoDao.updateTodoInTask(todo);
  Future delete(int id) => todoDao.deleteTodoInTask(id);
}
