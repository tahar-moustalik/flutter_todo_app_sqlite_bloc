import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/bloc/tasks_bloc.dart';

import '../models/Task.dart';
import '../screens/TaskDetailScreen.dart';
import '../utils/hex_color.dart';
import 'CardTasksList.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final TasksBloc tasksBloc;

  TaskCard({this.task,this.tasksBloc});

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool refresh = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => TaskDetailScreen(widget.task)));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 5.0),
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: HexColor(widget.task.tagColor),
        child: Container(
          height: 250,
          width: 180,
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text(
                  widget.task.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .apply(color: Colors.white),
                ),
                      IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.white,
                  onPressed: () {
                    widget.tasksBloc.deleteTask(widget.task.id);
                  },
                ),
              ]),
              Expanded(
                child: CardTasksList(
                  tasks: widget.task.todos,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
