part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {
  const TodoEvent();
}

class TodoListFetched extends TodoEvent {
  final TaskListCategory taskListCategory;

  const TodoListFetched({required this.taskListCategory});
}

class TodoCreated extends TodoEvent {
  final Todo task;

  const TodoCreated({required this.task});
}

class TodoCompleted extends TodoEvent {
  final Todo task;
  final TaskListCategory? taskListCategory;


  const TodoCompleted({required this.task, this.taskListCategory});
}

class TodoSearched extends TodoEvent {
  final String searchedString;

  const TodoSearched({required this.searchedString});
}
