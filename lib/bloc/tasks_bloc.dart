import 'dart:async';

import '../models/Task.dart';
import '../repository/task_repository.dart';
import 'bloc.dart';

class TasksBloc implements Bloc {
  final _taskRespository = TaskRepository();
  final columns = ['id', 'title', 'tagColor'];
  final _tasksController = StreamController<List<Task>>.broadcast();

  Stream<List<Task>> get tasksStream => _tasksController.stream;

  TasksBloc() {

  }
  void getAllTasks() async {
    _tasksController.sink
        .add(await _taskRespository.getAllTasks(columns: columns));
  }

  void addTask(Task task) async {
    await _taskRespository.createTask(task);
    getAllTasks();
  }

  void deleteAllTasks() async {
    await _taskRespository.deleteAllTasks();
    getAllTasks();
  }

  void deleteTask(int taskId) async {
    await _taskRespository.deleteTask(taskId);
    getAllTasks();
  }

  @override
  void dispose() {
    _tasksController.close();
  }
}
