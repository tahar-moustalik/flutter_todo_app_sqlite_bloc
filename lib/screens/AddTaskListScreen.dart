import 'package:flutter/material.dart';

import '../models/Todo.dart';

class AddTaskListScreen extends StatefulWidget {
  @override
  _AddTaskListScreenState createState() => _AddTaskListScreenState();
}

class _AddTaskListScreenState extends State<AddTaskListScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _taskName;
  List<Todo> _todos = [];

  _addTaskItem() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Task name...',
                filled: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Task items',
                  style: Theme.of(context).textTheme.headline5,
                ),
                FlatButton(
                  onPressed: () {
                    _addTaskItemModalBottomSheet(context);
                  },
                  child: Icon(
                    Icons.add,
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_todos[index].text),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTaskItemModalBottomSheet(context) {
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
          return
              Padding(
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
                        decoration:
                            InputDecoration(hintText: 'Task item', filled: true),
                      ),
                    ),
                    SizedBox(height: 20,),
                    RaisedButton(
                      onPressed: _addTaskItem,
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
