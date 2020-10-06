import '../dao/task_dao.dart';
import '../models/Task.dart';

class TaskRepository {
  final taskTodo = TaskDao();

  Future getAllTasks({List<String> columns}) =>
      taskTodo.getTasks(columns: columns);
  Future createTask(Task task) => taskTodo.createTask(task);
  Future deleteAllTasks() => taskTodo.deleteAllTasks();
  Future deleteTask(int taskId) => taskTodo.deleteTask(taskId);
}
