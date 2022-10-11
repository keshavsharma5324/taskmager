import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/todos.dart';
import 'package:taskmanager/widget/todo_widget.dart';

class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;

    return SizedBox(
        height: todos.length * 106 + 70,
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Padding(
              padding: EdgeInsets.only(top: 0, left: 16, right: 10),
              child: Text(
                'COMPLETED',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
                child: Center(
                  child: Text(
                    Provider.of<TodosProvider>(context).todosCompleted.length >
                            9
                        ? '9+'
                        : Provider.of<TodosProvider>(context).todosCompleted.length.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ))
          ]),
          SizedBox(
              height: todos.length * 106,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
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
