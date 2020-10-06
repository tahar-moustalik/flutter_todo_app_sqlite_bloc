import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/tasks_bloc.dart';
import '../bloc/todos_bloc.dart';
import '../components/AppStateNotifier.dart';
import '../models/Task.dart';
import '../models/Todo.dart';
import '../utils/hex_color.dart';

class TaskDetailScreen extends StatefulWidget {
  Task task;
  TaskDetailScreen(Task task) {
    this.task = task;
  }

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _todosBloc = TodosBloc();
  //final todoFieldController = TextEditingController();
  final _tasksBloc = TasksBloc();

  @override
  void initState() {
    _todosBloc.getTodosOfTask(widget.task.id);
    super.initState();
  }

  @override
  void dispose() {
    _todosBloc.dispose();
    _tasksBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Provider.of<AppStateNotifier>(context, listen: false).isDarkMode;
    final parentCtxt = context;
    final Color taskColor = HexColor(widget.task.tagColor);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.task.title),
          backgroundColor: !isDarkMode ? taskColor : null,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: (!isDarkMode) ? taskColor : null,
          child: Icon(Icons.add),
          onPressed: () {
            _actionTodoToTaskModalSheet(context, null);
          },
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                  stream: _todosBloc.todoStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Todo>> snapshot) {
                    if (snapshot.hasData) {
                      int todoCount = snapshot.data.length;
                      if (todoCount > 0) {
                        int doneTodosCount = 0;
                        snapshot.data.forEach((element) {
                          if (element.done) {
                            doneTodosCount++;
                          }
                        });
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: !isDarkMode
                                        ? AlwaysStoppedAnimation<Color>(
                                            taskColor)
                                        : null,
                                    backgroundColor: Colors.grey[200],
                                    value: (doneTodosCount / todoCount),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  '$doneTodosCount of $todoCount Todos',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .apply(
                                          color:
                                              (!isDarkMode) ? taskColor : null),
                                ),
                              ]),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'No todos in this task , create one !',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        );
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              Flexible(
                child: StreamBuilder(
                    stream: _todosBloc.todoStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Todo>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) {
                              return Dismissible(
                                background: Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  padding:
                                      EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 0.0),
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                secondaryBackground: Container(
                                  alignment: AlignmentDirectional.centerEnd,
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 24.0, 0.0),
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                key: Key(snapshot.data[index].id.toString()),
                                onDismissed: (direction) {
                                  _todosBloc.deleteTodoInTask(
                                      snapshot.data[index].taskId,
                                      snapshot.data[index].id);
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Todo is Deleted'),
                                    backgroundColor: Colors.red,
                                  ));
                                },
                                child: Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 6.0),
                                  child: ListTile(
                                    onLongPress: () {
                                      _actionTodoToTaskModalSheet(
                                          parentCtxt, snapshot.data[index]);
                                    },
                                    selected: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 10.0),
                                    leading: Container(
                                      padding: EdgeInsets.only(right: 8.0),
                                      decoration: new BoxDecoration(
                                          border: new Border(
                                              right:
                                                  new BorderSide(width: 1.0))),
                                      child: Checkbox(
                                        activeColor:
                                            !isDarkMode ? taskColor : null,
                                        value: snapshot.data[index].done,
                                        onChanged: (bool value) {
                                          var changed = snapshot.data[index];
                                          changed.done = value;
                                          _todosBloc.updateTodoInTask(changed);
                                        },
                                      ),
                                    ),
                                    title: Text(snapshot.data[index].text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .apply(
                                                decoration: (snapshot
                                                        .data[index].done)
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                                color:
                                                    (snapshot.data[index].done)
                                                        ? ((isDarkMode)
                                                            ? Theme.of(context)
                                                                .accentColor
                                                            : taskColor)
                                                        : null)),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ]));
  }

  void _actionTodoToTaskModalSheet(context, Todo todo) {
    var initialText = todo == null ? '' : todo.text;
    final todoFieldController = TextEditingController(text: initialText);
    showModalBottomSheet(
        enableDrag: true,
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
                    controller: todoFieldController,
                    decoration:
                        InputDecoration(hintText: 'Todo name', filled: true),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    if (todo == null) {
                      final newTodo = Todo(
                          text: todoFieldController.value.text,
                          taskId: widget.task.id);
                      _todosBloc.addTodoInTask(newTodo);
                    } else {
                      final updatedTodo = todo;
                      updatedTodo.text = todoFieldController.value.text;
                      _todosBloc.updateTodoInTask(updatedTodo);
                    }
                    todoFieldController.clear();
                    Navigator.pop(context);
                  },
                  child: (todo == null) ? Icon(Icons.add) : Icon(Icons.update),
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  color: HexColor(widget.task.tagColor),
                )
              ],
            ),
          );
        });
  }
}
