import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/models/todo.dart';
import 'package:taskmanager/providers/todos.dart';
import 'package:taskmanager/widget/todo_form_widget.dart';

class EditTodoPage extends StatefulWidget {
  final Todo? todo;

  const EditTodoPage({Key? key, @required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  String? title;
  String? description;
  DateTime? date;

  @override
  void initState() {
    super.initState();

    title = widget.todo!.title;
    description = widget.todo!.description;
    date = widget.todo!.date;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xff2EBAEF)),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Center(child: Text('Edit your task')),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                provider.removeTodo(widget.todo!);

                Navigator.of(context).pop();
              },
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
              title: title!,
              description: description!,
              date: date,
              opName: 'SAVE',
              onChangedDate: (date) => setState(() => this.date = date),
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: saveTodo,
            ),
          ),
        ),
      );

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);

      provider.updateTodo(widget.todo!, title!, description!, date!);

      Navigator.of(context).pop();
    }
  }
}
