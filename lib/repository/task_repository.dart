import 'package:flutter_mobile_app/dao/task_dao.dart';
import 'package:flutter_mobile_app/models/Task.dart';

class TaskRepository {
  final taskTodo = TaskDao();

  Future getAllTasks({List<String> columns}) =>
      taskTodo.getTasks(columns: columns);
  Future createTask(Task task) => taskTodo.createTask(task);
  Future deleteAllTasks() => taskTodo.deleteAllTasks();
  Future deleteTask(int taskId) => taskTodo.deleteTask(taskId);
}
