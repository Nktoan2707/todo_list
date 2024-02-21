import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/common/constants.dart';
import 'package:todo_list/data/models/domain/task.dart';
import 'package:todo_list/features/home/bloc/home_bloc.dart';
import 'package:todo_list/features/home/pages/add_task_page.dart';

class TaskListItemView extends StatefulWidget {
  final Task task;
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
          child: Icon(
            Icons.check_box_outline_blank,
          ),
          onTap: () {
            context.read<HomeBloc>().add(HomeTaskCompleted(
                task: widget.task, taskListCategory: widget.taskListCategory));
          },
        ),
        title: Text(widget.task.title!),
        trailing: Icon(Icons.more_vert),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(widget.task.note!),
              margin: EdgeInsets.only(top: 10),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: Colors.blueGrey[100],
                leading: Icon(Icons.calendar_month_outlined),
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
