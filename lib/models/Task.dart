import 'dart:convert';
import 'dart:ui';

import 'package:flutter_mobile_app/models/Todo.dart';
import 'package:flutter_mobile_app/utils/hex_color.dart';

class Task {
  int id;
  String title;
  String tagColor;
  List<Todo> todos = [];
  Task({this.id, this.title, this.tagColor});

  factory Task.fromDatabaseJson(Map<String, dynamic> json) => Task(
      id: json['id'],
      title: json['title'],
      tagColor: json['tagColor']);
  Map<String, dynamic> toDatabaseJson() =>
      {"id": id, "title": title, "tagColor": tagColor};
}
