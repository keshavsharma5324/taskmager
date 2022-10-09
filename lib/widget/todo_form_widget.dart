import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/todos.dart';

class TodoFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  DateTime? date;
  final ValueChanged<DateTime>? onChangedDate;
  final ValueChanged<String>? onChangedTitle;
  final ValueChanged<String>? onChangedDescription;
  final VoidCallback? onSavedTodo;

  TodoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.date,
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
            buildTitle(),
            SizedBox(height: 8),
            buildDescription(),
            TextButton(
                onPressed: () {
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
                child: Text(
                  date != null ? date.toString().substring(0, 10) : 'Pick Date',
                  style: TextStyle(color: Colors.blue),
                )),
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
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: description,
        onChanged: onChangedDescription,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Description',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedTodo,
          child: Text('Save'),
        ),
      );
}
