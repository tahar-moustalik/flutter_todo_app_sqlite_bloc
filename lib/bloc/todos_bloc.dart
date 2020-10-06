import 'dart:async';

import 'package:flutter_mobile_app/bloc/bloc.dart';
import 'package:flutter_mobile_app/models/Todo.dart';
import 'package:flutter_mobile_app/repository/todo_repository.dart';

class TodosBloc implements Bloc {
  final _todoRepository = TodoRepository();

  final _todosController = StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get todoStream => _todosController.stream;

  void getTodosOfTask(int taskId) async {
    _todosController.sink
        .add(await _todoRepository.getAllTodosInTask(taskId: taskId));
  }

  void addTodoInTask(Todo todo) async {
    await _todoRepository.createTodo(todo);
    getTodosOfTask(todo.taskId);
  }

  void updateTodoInTask(Todo todo) async {
    await _todoRepository.updateTodo(todo);
    getTodosOfTask(todo.taskId);
  }

  void deleteTodoInTask(int taskId, int id) async {
    await _todoRepository.delete(id);
    getTodosOfTask(taskId);
  }

  @override
  void dispose() {
    _todosController.close();
  }
}
