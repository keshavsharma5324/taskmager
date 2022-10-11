import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/Screens/edit_todo_page.dart';
import 'package:taskmanager/models/todo.dart';
import 'package:taskmanager/providers/todos.dart';
import 'package:taskmanager/utils/utils.dart';
import 'package:intl/intl.dart';

class TodoWidget extends StatelessWidget {
  final Todo? todo;

  const TodoWidget({
    @required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          key: Key(todo!.id!),
          children: [
            todo!.isDone == false
                ? SlidableAction(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                    label: 'Completed',
                    icon: Icons.check,
                    onPressed: (BuildContext context) {
                      final provider =
                          Provider.of<TodosProvider>(context, listen: false);
                      final isDone = provider.toggleTodoStatus(todo!);

                      Utils.showSnackBar(
                        context,
                        isDone ? 'Task completed' : 'Task marked incomplete',
                      );
                    },
                  )
                : SlidableAction(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    label: 'InComplete',
                    icon: Icons.highlight_off_outlined,
                    onPressed: (BuildContext context) {
                      final provider =
                          Provider.of<TodosProvider>(context, listen: false);
                      final isDone = provider.toggleTodoStatus(todo!);

                      Utils.showSnackBar(
                        context,
                        isDone ? 'Task completed' : 'Task marked incomplete',
                      );
                    },
                  ),
          ],
        ),
        child: buildTodo(context),
      ));

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, todo!),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                      color: const Color.fromARGB(255, 238, 238, 238)),
                ),
                child: Icon(
                  Icons.task_outlined,
                  color: const Color.fromARGB(255, 7, 218, 230).withOpacity(1),
                ),
              ),
             
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      todo!.title!,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    if (todo!.description!.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          todo!.description!,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 16, height: 1, color: Colors.grey),
                        ),
                      )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  '${Utils().returnMonth(todo!.date!)[0].toUpperCase()}${Utils().returnMonth(todo!.date!).substring(1, 3)} ${todo!.date!.day}, ${todo!.date!.year}',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: .5,
                      color: Colors.grey),
                ),
              )
             
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}
