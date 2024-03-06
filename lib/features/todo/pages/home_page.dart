import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/pages/search_task_page.dart';
import 'package:todo_list/features/todo/pages/task_list_page.dart';


import '../../../common/constants.dart';
import '../bloc/todo_bloc.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  static const String pageId = "/home";


  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return BlocListener<TodoBloc, TodoState>(
      listener: (_, state) {
        if (state is TodoFetchSuccess) {
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
              child: const Padding(
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
          child: const Icon(Icons.add),
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
                          context.read<TodoBloc>().add(const TodoListFetched(taskListCategory:  TaskListCategory.today));
                        },
                        tileColor: Colors.white,
                        leading: const Icon(Icons.sunny),
                        title: const Text("Today"),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        onTap: () {
                          context.read<TodoBloc>().add(const TodoListFetched(taskListCategory:  TaskListCategory.upcoming));

                        },
                        tileColor: Colors.white,
                        leading: const Icon(Icons.calendar_month_outlined),
                        title: const Text("Upcoming"),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        onTap: () {
                          context.read<TodoBloc>().add(const TodoListFetched(taskListCategory:  TaskListCategory.all));
                        },
                        tileColor: Colors.white,
                        leading: const Icon(Icons.task),
                        title: const Text("All"),
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
