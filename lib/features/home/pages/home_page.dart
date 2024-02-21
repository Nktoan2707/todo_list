import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/home/pages/search_task_page.dart';
import 'package:todo_list/features/home/pages/task_list_page.dart';

import '../../../common/constants.dart';
import '../bloc/home_bloc.dart';
import 'add_task_page.dart';

class HomePage extends StatelessWidget {
  static const String pageId = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (_, state) {
        if (state is HomeGetTaskListSuccess) {
          Navigator.of(context).pushNamed(TaskListPage.pageId);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: tdBGColor,
          title: const Text("TODO List", style: TextStyle(color: Colors.black)),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: false,
          actions: [
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Icon(Icons.search),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(SearchTaskPage.pageId);
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddTaskPage.pageId);
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      child: ListTile(
                        onTap: () {
                          context.read<HomeBloc>().add(const HomeTaskListFetched(taskListCategory:  TaskListCategory.today));
                        },
                        tileColor: Colors.white,
                        leading: Icon(Icons.sunny),
                        title: Text("Today"),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        onTap: () {
                          context.read<HomeBloc>().add(const HomeTaskListFetched(taskListCategory:  TaskListCategory.upcoming));

                        },
                        tileColor: Colors.white,
                        leading: Icon(Icons.calendar_month_outlined),
                        title: Text("Upcoming"),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        onTap: () {
                          context.read<HomeBloc>().add(const HomeTaskListFetched(taskListCategory:  TaskListCategory.all));
                        },
                        tileColor: Colors.white,
                        leading: Icon(Icons.task),
                        title: Text("All"),
                      ),
                    ),
                    const Divider(
                      color: Colors.black87,
                      indent: 16,
                      endIndent: 0,
                      height: 6.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
