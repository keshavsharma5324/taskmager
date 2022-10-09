import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/todos.dart';
import 'package:taskmanager/widget/completed_list_widget.dart';
import 'package:taskmanager/widget/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  GlobalKey<ScaffoldState>? scaffoldKey;

  TodoListWidget({this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;
    final time = DateTime.now();

    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 199, 224, 245),
      ),
      SingleChildScrollView(
          child: Column(children: [
        Stack(children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                //  color: Colors.indigo.shade900,
                image: DecorationImage(
              image: AssetImage("assets/sky.jpg"),
              fit: BoxFit.cover,
            )),
          ),
          Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(bottom: 24, left: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Tasks',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            time.toString().substring(0, 10),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(.6)),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Progress',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(.6)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 30,
                              child: CircularProgressIndicator(
                                semanticsLabel: 'Progress',
                                value: provider.progress(),
                              ))
                        ],
                      )
                    ],
                  )
                ],
              )),
        ]),
        todos.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'No todos.',
                    style: TextStyle(fontSize: 20),
                  ),
                ))
            : Container(
                height: todos.length * 120 + 70,
                child: SingleChildScrollView(
                    child: Column(children: [
                  const Center(
                    child: Text(
                      'Tasks.',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                      height: todos.length * 120,
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16),
                        separatorBuilder: (context, index) =>
                            Container(height: 8),
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final todo = todos[index];

                          return TodoWidget(todo: todo);
                        },
                      ))
                ]))),
        CompletedListWidget()
      ])),
      Positioned(
          top: 50,
          left: 20,
          child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.transparent),
              child: InkWell(
                child: const Icon(Icons.subject,
                    size: 28, color: Colors.white //Color(0xFF1A237E),
                    ),
                onTap: () {
                  scaffoldKey!.currentState!.openDrawer();
                },
              )))
    ]);
  }
}
