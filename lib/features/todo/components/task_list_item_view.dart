import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/common/constants.dart';
import 'package:todo_list/data/models/domain/todo.dart';
import 'package:todo_list/features/todo/bloc/todo_bloc.dart';


class TaskListItemView extends StatefulWidget {
  final Todo task;
  final TaskListCategory? taskListCategory;

  const TaskListItemView(
      {super.key, required this.task, this.taskListCategory});

  @override
  State<TaskListItemView> createState() => _TaskListItemViewState();
}

class _TaskListItemViewState extends State<TaskListItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {},
        minVerticalPadding: 10,
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: GestureDetector(
          child: const Icon(
            Icons.check_box_outline_blank,
          ),
          onTap: () {
            context.read<TodoBloc>().add(TodoCompleted(
                task: widget.task, taskListCategory: widget.taskListCategory));
          },
        ),
        title: Text(widget.task.title!),
        trailing: const Icon(Icons.more_vert),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(widget.task.note!),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: Colors.blueGrey[100],
                leading: const Icon(Icons.calendar_month_outlined),
                title: Text("${widget.task.date!} ${widget.task.dueTime!}"),
                titleAlignment: ListTileTitleAlignment.center,
              ),
            )
          ],
        ),
        titleAlignment: ListTileTitleAlignment.top,
      ),
    );
  }
}
