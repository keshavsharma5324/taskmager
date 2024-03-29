import 'package:flutter/cupertino.dart';
import 'package:taskmanager/utils/utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime? createdTime;
  String? title;
  String? id;
  String? description;
  bool? isDone;
  String? uuid;
  DateTime? date;

  Todo(
      {@required this.createdTime,
      @required this.title,
      this.description = '',
      this.id,
      this.date,
      this.isDone = false,
      this.uuid});

  static Todo fromJson(Map<String, dynamic> json) => Todo(
      createdTime: Utils.toDateTime(json['createdTime']),
      title: json['title'],
      description: json['description'],
      id: json['id'],
      isDone: json['isDone'],
      date: Utils.toDateTime(json['date']),
      uuid: json['uuid']);

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime!),
        'title': title,
        'description': description,
        'id': id,
        'date': date,
        'isDone': isDone,
        'uuid': uuid
      };
}
