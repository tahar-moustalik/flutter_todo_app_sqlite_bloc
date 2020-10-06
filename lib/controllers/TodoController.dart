import 'package:flutter_mobile_app/models/Todo.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class TodoController extends GetxController {
  var todos = List<Todo>().obs;

  @override
  void onInit() {
    List storedTodos = GetStorage().read<List>('todos');

    if (storedTodos != null) {
      todos = storedTodos.map((e) => Todo.fromDatabaseJson(e)).toList().obs;
      todos.sort((a, b) => b.done.toString().compareTo(a.done.toString()));
    }
    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }
}
