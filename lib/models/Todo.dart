import 'package:equatable/equatable.dart';
class Todo extends Equatable {
  String text;
  bool done;
  int id;
  int taskId;
  Todo({this.taskId,this.id,this.text, this.done = false});

  factory Todo.fromDatabaseJson(Map<String, dynamic> json) =>
      Todo(id: json['id'], text: json['text'], done: json['done'] == 0 ? false: true,
      taskId: json['task_id']);

  Map<String, dynamic> toDatabaseJson() => {'id': id,'text': text, 'done': done ? 1:0,'task_id':taskId};

  @override
  List<Object> get props => [text, done, id];
}
