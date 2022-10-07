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

  /*static Stream<List<Todo>> readTodos() {
    return FirebaseFirestore.instance
        .collection('tasks')
        .orderBy(TodoField.createdTime, descending: true)
        //.where('date', isEqualTo: mydate)
        .snapshots()
        .map((snapshor) =>
            snapshor.docs.map((doc) => Todo.fromJson(doc.data())).toList());
  }*/

  Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
      .collection('todo')
      .where('uuid', isEqualTo: Users().getID())
      .snapshots()
      .map((snapshor) =>
          snapshor.docs.map((doc) => Todo.fromJson(doc.data())).toList());
  // ignore: unnecessary_cast
  //.transform(Utils.transformer(Todo.fromJson)
  //   as StreamTransformer<QuerySnapshot, List<Todo>>);

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }
}
