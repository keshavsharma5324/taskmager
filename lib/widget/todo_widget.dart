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
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            //dismissible: DismissiblePane(onDismissed: () {}),
            key: Key(todo!.id!),

            children: [
              SlidableAction(
                backgroundColor: Colors.green,
                //onTap: () => editTodo(context, todo!),
                label: 'Edit',
                icon: Icons.edit,
                onPressed: (BuildContext context) {
                  editTodo(context, todo!);
                },
              ),
              SlidableAction(
                foregroundColor: Colors.green,
                //onTap: () => editTodo(context, todo!),
                label: 'Delete',
                icon: Icons.delete,
                onPressed: (BuildContext context) {
                  deleteTodo(context, todo!);
                },
              )
            ],
          ),
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, todo!),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text(
                    todo!.date!.day.toString(),
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -.6),
                  ),
                  Text(
                    returnMonth(todo!.date!).substring(0, 3).toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  Text(
                    todo!.date!.year.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -.5),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo!.title!,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (todo!.description!.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          todo!.description!,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: todo!.isDone,
                onChanged: (_) {
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

  String returnMonth(DateTime date) {
    return DateFormat.MMMM().format(date);
  }
}
