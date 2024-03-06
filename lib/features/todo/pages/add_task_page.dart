import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/common/constants.dart';
import 'package:todo_list/features/todo/bloc/todo_bloc.dart';

import '../../../data/models/domain/todo.dart';
import '../components/button.dart';
import '../components/input_field.dart';
import '../theme.dart';

class AddTaskPage extends StatefulWidget {
  static const String pageId = "/add_task_page";

  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _dueTime = DateFormat(TIME_FORMAT).format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: const ListTile(
          leading: Icon(Icons.sunny),
          title: Text("My Day"),
          horizontalTitleGap: 0,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () => _getDateFromUser(),
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              InputField(
                title: 'Due Time',
                hint: _dueTime,
                widget: IconButton(
                  onPressed: () => _getTimeFromUser(),
                  icon: const Icon(
                    Icons.access_time_rounded,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyButton(
                      label: 'Create Task',
                      onTap: () {
                        if (!_validateData()) {
                          return;
                        }

                        Todo createTask = Todo(
                          title: _titleController.text,
                          note: _noteController.text,
                          isCompleted: 0,
                          date: DateFormat.yMd().format(_selectedDate),
                          dueTime: _dueTime,
                        );

                        context
                            .read<TodoBloc>()
                            .add(TodoCreated(task: createTask));
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      //TODO: add task to local list
      Navigator.of(context).pop();
      return true;
    } else if (_titleController.text.isNotEmpty ||
        _noteController.text.isNotEmpty) {
      const snackBar = SnackBar(
        content: Text('All fields are required!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print(
          '############################ SOMETHING WRONG HAPPENED #############################');
    }

    return false;
  }

  _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    } else {
      print('Please select correct date');
    }
  }

  _getTimeFromUser() async {
    TimeOfDay? pickedTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()));

    // ignore: use_build_context_synchronously
    String formattedTime = pickedTime!.format(context);

    setState(() => _dueTime = formattedTime);
  }
}
