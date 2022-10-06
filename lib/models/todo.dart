import 'package:json_annotation/json_annotation.dart';
import 'package:taskmanager/models/task.dart';
//import 'package:todo_app_with_flutter_and_firebase/models/task.dart';


class Todo {
  Todo({
    this.uuid,
    this.todotitle,
    this.tasklist
  });

  String? uuid;
  String? todotitle;
  String? tasklist;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    uuid: json["uuid"],
    todotitle: json["todo_title"],
    tasklist: json["task_list"]
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "todo_title": todotitle,
    "task_list": tasklist
  };
}