import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/controllers/TodoController.dart';
import 'package:flutter_mobile_app/screens/TodoScreen.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController _todoController = Get.put(TodoController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Fire Todo App'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.add),
        onPressed: () {
          Get.to(TodoScreen(null));
        },
      ),
      body: Container(
        child: Obx(() => ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  title: Text(
                    _todoController.todos[index].text,
                    style: (_todoController.todos[index].done)
                        ? TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough)
                        : TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                  onTap: () {
                    Get.to(TodoScreen(index));
                  },
                  trailing: Icon(CupertinoIcons.right_chevron),
                  leading: Checkbox(
                    value: _todoController.todos[index].done,
                    onChanged: (value) {
                      var changed = _todoController.todos[index];
                      changed.done = value;
                      _todoController.todos[index] = changed;
                      _todoController.todos.sort((a, b) =>
                          b.done.toString().compareTo(a.done.toString()));
                    },
                  ),
                ),
            separatorBuilder: (_, __) => Divider(),
            itemCount: _todoController.todos.length)),
      ),
    );
  }
}
