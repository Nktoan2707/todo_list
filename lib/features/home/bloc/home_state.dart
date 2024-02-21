part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  final TaskListCategory? taskListCategory;
  final List<Task>? taskList;

  const HomeState({this.taskListCategory, this.taskList});
}

class HomeInitial extends HomeState {
  const HomeInitial() : super(taskList: null, taskListCategory: null);
}

class HomeGetTaskListSuccess extends HomeState {
  const HomeGetTaskListSuccess(
      {required super.taskListCategory, required super.taskList});
}

class HomeCreateTaskSuccess extends HomeState {
  final Task createdTask;

  const HomeCreateTaskSuccess({required this.createdTask})
      : super(taskListCategory: null, taskList: null);
}

class HomeCompleteTaskSuccess extends HomeState {
  const HomeCompleteTaskSuccess(
      {required super.taskList, required super.taskListCategory});
}

class HomeSearchTaskSuccess extends HomeState {
  const HomeSearchTaskSuccess({required super.taskList})
      : super(taskListCategory: null);
}
