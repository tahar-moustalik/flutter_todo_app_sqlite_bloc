import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/components/CardTaskItem.dart';
import 'package:flutter_mobile_app/models/Todo.dart';

class CardTasksList extends StatelessWidget {
  final List<Todo> tasks;
  CardTasksList({this.tasks});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) =>
            CardTaskItem(text: tasks[index].text,done:tasks[index].done,));
  }
}
