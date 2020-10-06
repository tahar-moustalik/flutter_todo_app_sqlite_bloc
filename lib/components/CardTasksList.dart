import 'package:flutter/material.dart';

import '../models/Todo.dart';
import 'CardTaskItem.dart';

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
