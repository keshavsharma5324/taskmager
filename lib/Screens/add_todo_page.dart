import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/models/todo.dart';
import 'package:taskmanager/models/users.dart';
import 'package:taskmanager/providers/todos.dart';
import 'package:taskmanager/utils/utils.dart';
import 'package:taskmanager/widget/todo_form_widget.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({
    Key? key,
  }) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  DateTime? date;
  String description = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xff2EBAEF)),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Center(child: Text('Add new thing')),
          actions: [
            IconButton(
              icon: const Icon(Icons.legend_toggle),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          color: Color(0xff46539E),
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
              title: title,
              description: description,
              date: date,
              opName: 'ADD TOUR THING',
              onChangedDate: (date) => setState(() => this.date = date),
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: addTodo,
            ),
          ),
        ),
      );

  void addTodo() {
    final isValid = _formKey.currentState!.validate();
    print(date.toString());

    if (date != null) {
      if (!isValid) {
        return;
      } else {
        final todo = Todo(
            id: DateTime.now().toString(),
            title: title,
            description: description,
            createdTime: DateTime.now(),
            date: date,
            uuid: Users().getID());

        final provider = Provider.of<TodosProvider>(context, listen: false);
        provider.addTodo(todo);

        Navigator.of(context).pop();
      }
    } else {
      Utils.showSnackBar(context, 'Please pick a valid date to continue');
    }
  }
}
