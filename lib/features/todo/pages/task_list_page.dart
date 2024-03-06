import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/common/constants.dart';
import 'package:todo_list/data/models/domain/todo.dart';
import 'package:todo_list/features/todo/components/task_list_item_view.dart';

import '../bloc/todo_bloc.dart';

class TaskListPage extends StatelessWidget {
  static const String pageId = "/task_list_page";

  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        late final List<Todo> listTask;
        late final String? taskListCategory;
        if (state is TodoFetchSuccess || state is TodoCompleteSuccess){
          listTask = state.taskList!;
          taskListCategory = state.taskListCategory!.name[0].toUpperCase() + state.taskListCategory!.name.substring(1);
        }

        return Scaffold(
          backgroundColor: tdBGColor,
          appBar: AppBar(
            title: ListTile(
              leading: const Icon(Icons.sunny),
              title: Text(taskListCategory!),
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
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: listTask.length,
                    itemBuilder: (context, index) {
                      return TaskListItemView(task: listTask[index], taskListCategory: state.taskListCategory, );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.grey,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
