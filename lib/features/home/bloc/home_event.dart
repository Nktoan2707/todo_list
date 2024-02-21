part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

class HomeTaskListFetched extends HomeEvent {
  final TaskListCategory taskListCategory;

  const HomeTaskListFetched({required this.taskListCategory});
}

class HomeTaskCreated extends HomeEvent {
  final Task task;

  const HomeTaskCreated({required this.task});
}

class HomeTaskCompleted extends HomeEvent {
  final Task task;
  final TaskListCategory? taskListCategory;


  const HomeTaskCompleted({required this.task, this.taskListCategory});
}

class HomeTaskSearched extends HomeEvent {
  final String searchedString;

  const HomeTaskSearched({required this.searchedString});
}
