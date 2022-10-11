import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/todos.dart';

class TodoFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  DateTime? date;
  final String? opName;
  final ValueChanged<DateTime>? onChangedDate;
  final ValueChanged<String>? onChangedTitle;
  final ValueChanged<String>? onChangedDescription;
  final VoidCallback? onSavedTodo;

  TodoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.date,
    this.opName,
    @required this.onChangedDate,
    @required this.onChangedTitle,
    @required this.onChangedDescription,
    @required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
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
            ),
            const SizedBox(
              height: 16,
            ),
            buildTitle(),
            const SizedBox(height: 8),
            buildDescription(),
            InkWell(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(2000, 3, 5),
                  maxTime: DateTime(2050, 6, 7),
                  onChanged: onChangedDate,
                  onConfirm: (da) {
                    Provider.of<TodosProvider>(context).selectedDate(da);
                  },
                  currentTime: DateTime(2000, 3, 5),
                );
              },
              child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 120, 119, 119)))),
                  child: Text(
                      date != null
                          ? date.toString().substring(0, 10)
                          : 'Pick Date',
                      style: TextStyle(
                        color: date != null ? Colors.white : Colors.grey,
                      ))),
            ),
            SizedBox(height: 16),
            buildButton(),
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title!.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        style: TextStyle(color: Colors.white),
        // ignore: prefer_const_constructors
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: description,
        onChanged: onChangedDescription,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'Description',
            hintStyle: TextStyle(color: Colors.grey)),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
            )),
            backgroundColor: MaterialStateProperty.all(Color(0xff2EBAEF)),
            shadowColor: MaterialStateProperty.all<Color>(Colors.black),
            elevation: MaterialStateProperty.all(10),
          ),
          onPressed: onSavedTodo,
          child: Text(opName!),
        ),
      );
}
