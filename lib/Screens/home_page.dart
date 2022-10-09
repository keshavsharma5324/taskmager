import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/api/firebase_api.dart';
import 'package:taskmanager/models/todo.dart';
import 'package:taskmanager/models/users.dart';
import 'package:taskmanager/providers/authProvider.dart';
import 'package:taskmanager/providers/todos.dart';
import 'package:taskmanager/widget/add_todo_dialog_widget.dart';
import 'package:taskmanager/widget/completed_list_widget.dart';
import 'package:taskmanager/widget/todo_list_widget.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 7, 218, 230).withOpacity(1),
              ),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text(
                      'Hi, ${Users().getUserName()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${Users().getUserEmail()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ]))),
          ListTile(
            title: const Text('LOGOUT'),
            onTap: () {
              Provider.of<Authentication>(context, listen: false)
                  .logout(context);
              Navigator.pop(context);
            },
          ),
        ],
      )),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi().readTodos(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final todos = snapshot.data;

                final provider = Provider.of<TodosProvider>(context);
                provider.setTodos(todos!);

                return TodoListWidget(
                  scaffoldKey: _scaffoldKey,
                );
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        //  ),
        backgroundColor: Color.fromARGB(255, 7, 218, 230).withOpacity(1),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTodoDialogWidget(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
