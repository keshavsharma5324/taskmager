import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/todos.dart';
import 'package:taskmanager/widget/todo_widget.dart';

class CompletedListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? const Center(
            child: Text(
              'No completed tasks.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : Container(
            height: todos.length * 120 + 70,
            child: SingleChildScrollView(
                child: Column(children: [
              const Center(
                child: Text(
                  'Completed tasks.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                  height: todos.length * 120,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(16),
                    separatorBuilder: (context, index) => Container(height: 8),
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];

                      return TodoWidget(todo: todo);
                    },
                  ))
            ])));
  }
}
