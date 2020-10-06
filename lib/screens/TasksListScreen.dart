import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobile_app/bloc/tasks_bloc.dart';
import 'package:flutter_mobile_app/utils/generate_random_color.dart';
import 'package:provider/provider.dart';

import '../components/AppStateNotifier.dart';
import '../components/CardsList.dart';
import '../models/Task.dart';
import '../models/Todo.dart';
import '../theme.dart';
import 'AddTaskListScreen.dart';

class TasksListScreen extends StatefulWidget {
  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  final taskFieldController = TextEditingController();

  final List<Task> tasks = [];

  final _tasksBloc = TasksBloc();


  @override
  void initState() {
    _tasksBloc.getAllTasks();
    super.initState();
  }

  @override
  void dispose() {
    _tasksBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks List'), actions: <Widget>[
        Switch(
          value:
              Provider.of<AppStateNotifier>(context, listen: false).isDarkMode,
          onChanged: (boolVal) {
            Provider.of<AppStateNotifier>(context, listen: false)
                .updateTheme(boolVal);
          },
        ),
        /*   IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _tasksBloc.deleteAllTasks();
                },
              )*/
      ]),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                FlatButton(
                  onPressed: () {
                    _addTaskModalBottomSheet(context);
                  },
                  child: Icon(Icons.add),
                ),
                Text(
                  'Add list',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            StreamBuilder(
                stream: _tasksBloc.tasksStream,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                  return Container(
                      height: 300, child: CardsList(snapshot: snapshot,tasksBloc:_tasksBloc));
                }),
          ]),
    );
  }

  void _addTaskModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextField(
                    controller: taskFieldController,
                    decoration:
                        InputDecoration(hintText: 'Task name', filled: true),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    final newTask = Task(
                        title: taskFieldController.value.text,
                        tagColor: generateRandomHexColor());
                    _tasksBloc.addTask(newTask);
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.add),
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  color: Theme.of(context).accentColor,
                )
              ],
            ),
          );
        });
  }
}
