part of 'todo_bloc.dart';

@immutable
abstract class TodoState {
  final TaskListCategory? taskListCategory;
  final List<Todo>? taskList;

  const TodoState({this.taskListCategory, this.taskList});
}

class TodoInitial extends TodoState {
  const TodoInitial() : super(taskList: null, taskListCategory: null);
}

class TodoFetchSuccess extends TodoState {
  const TodoFetchSuccess(
      {required super.taskListCategory, required super.taskList});
}

class TodoCreateSuccess extends TodoState {
  final Todo createdTask;

  const TodoCreateSuccess({required this.createdTask})
      : super(taskListCategory: null, taskList: null);
}

class TodoCompleteSuccess extends TodoState {
  const TodoCompleteSuccess(
      {required super.taskList, required super.taskListCategory});
}

class TodoSearchSuccess extends TodoState {
  const TodoSearchSuccess({required super.taskList})
      : super(taskListCategory: null);
}
