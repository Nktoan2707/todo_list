import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/data/repositories/todo_repository.dart';
import 'package:todo_list/features/todo/bloc/todo_bloc.dart';
import 'package:todo_list/features/todo/pages/add_task_page.dart';
import 'package:todo_list/features/todo/pages/home_page.dart';
import 'package:todo_list/features/todo/pages/search_task_page.dart';
import 'package:todo_list/features/todo/pages/task_list_page.dart';


import 'package:todo_list/widgets/loading_page.dart';


class AppRouter {
  final TodoBloc _homeBloc = TodoBloc(taskRepository: TodoRepository());

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.pageId:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case TaskListPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _homeBloc,
                  child: const TaskListPage(),
                ));

      case HomePage.pageId:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: _homeBloc, child: const HomePage()));

      case AddTaskPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _homeBloc, child: const AddTaskPage()));

      case SearchTaskPage.pageId:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _homeBloc, child: const SearchTaskPage()));

      default:
        return null;
    }
  }

  void dispose() {
    _homeBloc.close();
  }
}
