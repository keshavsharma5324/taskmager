import 'package:flutter/cupertino.dart';
import 'package:taskmanager/api/firebase_api.dart';
import 'package:taskmanager/models/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  String date = 'Please Pick Date For Task';

  void selectedDate(DateTime dateTime) {
    date = dateTime.toString();
    //return date!;
    notifyListeners();
  }

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  double progress() {
    if (_todos.length != 0) {
      double progress = todosCompleted.length / _todos.length;
      return progress;
    } else
      return 0;
  }

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  void removeTodo(Todo todo) => FirebaseApi.deleteTodo(todo);

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone!;
    FirebaseApi.updateTodo(todo);

    return todo.isDone!;
  }

  void updateTodo(
      Todo todo, String title, String description, DateTime dateTime) {
    todo.title = title;
    todo.description = description;
    todo.date = dateTime;

    FirebaseApi.updateTodo(todo);
  }
}
