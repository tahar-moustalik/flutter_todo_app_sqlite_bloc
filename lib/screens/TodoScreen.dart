import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/controllers/TodoController.dart';
import 'package:flutter_mobile_app/models/Todo.dart';
import 'package:get/get.dart';

class TodoScreen extends StatelessWidget {
  final TodoController _todoController = Get.find<TodoController>();
  final int index;
  TodoScreen(this.index);
  @override
  Widget build(BuildContext context) {
    String text = '';
    if (!this.index.isNull) {
      text = _todoController.todos[index].text;
    }
    TextEditingController textEditingController =
        TextEditingController(text: text);
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: 'What do you want to accomplish ?',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none),
              style: TextStyle(fontSize: 25.0),
              keyboardType: TextInputType.multiline,
              maxLines: 999,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                child: Text('Cancel'),
                color: Colors.red,
                onPressed: () {
                  Get.back();
                },
              ),
              RaisedButton(
                child: Text((this.index.isNull)?'Add':'Save'),
                color: Colors.green,
                onPressed: () {
                  if (this.index.isNull) {
                    _todoController.todos
                        .add(Todo(text: textEditingController.text));
                  } else {
                    var changed = _todoController.todos[index];
                    changed.text = textEditingController.text;
                    _todoController.todos[index] = changed;
                  }
                  Get.back();
                },
              )
            ],
          ),
        ],
      ),
    ));
  }
}
