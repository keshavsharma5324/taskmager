import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/models/todo.dart';
import 'package:toast/toast.dart';


/*class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  int backPressCounter = 0;
  int selectedExpansionTile = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Todo list"),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.login,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  /*AuthService.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                      settings: RouteSettings(name: '/login'),
                    ),
                    (Route<dynamic> route) => false,
                  );*/
                },
              )
            ],
          ),
          body: getTodoListBody(context),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.blue,
            label: Text("Add Todo"),
            icon: Icon(Icons.add),
            onPressed: () {
             /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodo(),
                  settings: RouteSettings(name: '/add_todo'),
                ),
              );*/
            },
          ),
        ),
      ),
    );
  }

  Widget getTodoListBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<Task>(context, listen: false).getTodoListOfCurrentUser(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        Widget child;
        if (snapshot.hasError) {
          child = Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          child = Center(
            child: Text(
              "Loading",
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (snapshot.data!.size == 0) {
          child = Center(
            child: Text("All TODOs are caught up"),
          );
        } else if (stask.dart
        task.g.dart
        todo.dart
        todo.g.dartnapshot.hasData && snapshot.data!.size > 0) {
          child = Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Todo todo = Todo.fromJson(snapshot.data.docs[index].data()) as Todo;
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  actions: [
                    IconSlideAction(
                      caption: 'Edit',
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTodo(todo),
                          ),
                        )
                      },
                    ),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => {TodoService().deleteByID(todo.uuid)},
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Card(
                      child: ExpansionTile(
                        initiallyExpanded: index == selectedExpansionTile,
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              selectedExpansionTile = index;
                            });
                          else
                            setState(() {
                              selectedExpansionTile = -1;
                            });
                        }),
                        leading: Icon(Icons.fiber_manual_record),
                        title: Text(
                          todo.todoTitle,
                          style: TextStyle(color: Colors.white),
                          maxLines: 2,
                        ),
                        children: todo.taskList
                            .asMap()
                            .entries
                            .map(
                              (task) => CheckboxListTile(
                                contentPadding: EdgeInsets.only(left: 30),
                                value: task.value.status,
                                title: Text(task.value.taskDescription),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      task.value.status = value;
                                      TodoService()
                                          .updateByID(todo.toJson(), todo.uuid);
                                    },
                                  );
                                },
                              ),
                            )
                            .toList(),
                        trailing: Icon(Icons.keyboard_arrow_down),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return child;
      },
    );
  }

  Future<bool> onWillPop() {
    if (backPressCounter < 1) {
      backPressCounter++;
      //Toast.show(msg, duration: duration, gravity: gravity);
      Toast.show("Press again to exit !!!",duration: 4000,gravity: Toast.center);
      Future.delayed(Duration(seconds: 2, milliseconds: 0), () {
        backPressCounter--;
      });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}*/
/*
class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      Expanded(
                          child: StreamBuilder(
                        stream: FireStoreCrud().getTasks(
                          mydate: DateFormat('yyyy-MM-dd').format(currentdate),
                        ),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<TaskModel>> snapshot) {
                          if (snapshot.hasError) {
                            return _nodatawidget();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const MyCircularIndicator();
                          }

                          return snapshot.data!.isNotEmpty
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var task = snapshot.data![index];
                                    Widget _taskcontainer = TaskContainer(
                                      id: task.id,
                                      color: colors[task.colorindex],
                                      title: task.title,
                                      starttime: task.starttime,
                                      endtime: task.endtime,
                                      note: task.note,
                                    );
                                    return InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, addtaskpage,
                                              arguments: task);
                                        },
                                        child: index % 2 == 0
                                            ? BounceInLeft(
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                child: _taskcontainer)
                                            : BounceInRight(
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                child: _taskcontainer));
                                  },
                                )
                              : _nodatawidget();
                        },
                      )),
    ]),);
  }
}*/
