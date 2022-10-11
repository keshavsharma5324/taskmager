import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/todos.dart';
import 'package:taskmanager/utils/utils.dart';
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
    final progress = (provider.progress() * 100).toString().split('.');

    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
      ),
      SingleChildScrollView(
          child: Column(children: [
        Stack(children: [
          Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                //  color: Colors.indigo.shade900,
                image: DecorationImage(
              image: AssetImage("assets/sky.jpg"),
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
              right: 0,
              child: Container(
                height: 280,
                width: MediaQuery.of(context).size.width -
                    (MediaQuery.of(context).size.width * provider.progress()),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.2),
                ),
              )),
          Container(
              height: 280,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(bottom: 0, left: 20, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your \nThings',
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            '${Utils().returnMonth(time)[0].toUpperCase()}${Utils().returnMonth(time).substring(1, 3)} ${time.day}, ${time.year}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .5,
                                color: Colors.white.withOpacity(.8)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(children: [
                            Stack(
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.black.withOpacity(.3),
                                      semanticsLabel: 'Progress',
                                      value: 1,
                                    )),
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: const Color(0xff2EBAEF),
                                      semanticsLabel: 'Progress',
                                      value: provider.progress(),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${progress[0]}% done',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .5,
                                  color: Colors.white.withOpacity(.8)),
                            ),
                          ]),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      )
                    ],
                  )
                ],
              )),
          Positioned(
            bottom: 0,
            child: Container(
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromARGB(70, 83, 158, 255),
                      Color.fromARGB(255, 16, 203, 197)
                    ]),
              ),
              //color: Color.fromARGB(255, 16, 203, 197),
              width: MediaQuery.of(context).size.width * provider.progress(),
            ),
          )
        ]),
        SizedBox(
            height: todos.length * 106 + 70,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16, left: 16),
                    child: Text(
                      'INBOX',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                      //color: Colors.green,
                      height: todos.length * 106,
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16),
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          color: Color.fromARGB(255, 238, 238, 238),
                        ),
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
          left: 5,
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
