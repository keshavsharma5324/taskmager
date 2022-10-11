import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmanager/models/todo.dart';
import 'package:taskmanager/models/users.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
      .collection('todo')
      .where('uuid', isEqualTo: Users().getID())
      .snapshots()
      .map((snapshor) =>
          snapshor.docs.map((doc) => Todo.fromJson(doc.data())).toList());

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }
}
