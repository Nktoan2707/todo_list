import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/common/constants.dart';
import 'package:todo_list/data/models/domain/task.dart';
import 'package:todo_list/features/home/components/task_list_item_view.dart';

import '../bloc/home_bloc.dart';

class TaskListPage extends StatelessWidget {
  static const String pageId = "/task_list_page";

  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        late final List<Task> listTask;
        late final String? taskListCategory;
        if (state is HomeGetTaskListSuccess || state is HomeCompleteTaskSuccess){
          listTask = state.taskList!;
          taskListCategory = state.taskListCategory!.name[0].toUpperCase() + state.taskListCategory!.name.substring(1);
        }

        return Scaffold(
          backgroundColor: tdBGColor,
          appBar: AppBar(
            title: ListTile(
              leading: Icon(Icons.sunny),
              title: Text(taskListCategory!),
              horizontalTitleGap: 0,
            ),
            actions: [
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
