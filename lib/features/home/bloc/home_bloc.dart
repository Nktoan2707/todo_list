import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/common/constants.dart';
import 'package:todo_list/data/models/domain/task.dart';
import 'package:todo_list/data/repositories/task_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TaskRepository _taskRepository;

  HomeBloc({required taskRepository})
      : _taskRepository = taskRepository,
        super(HomeInitial()) {
    on<HomeTaskListFetched>(_onHomeTaskListFetched);
    on<HomeTaskCreated>(_onHomeTaskCreated);
    on<HomeTaskCompleted>(_onHomeTaskCompleted);
    on<HomeTaskSearched>(_onHomeTaskSearched);
  }

  FutureOr<void> _onHomeTaskListFetched(
      HomeTaskListFetched event, Emitter<HomeState> emit) {

    List<Task> taskList = List<Task>.empty();

    switch (event.taskListCategory) {
      case TaskListCategory.today:
        taskList = _taskRepository.getTaskList(event.taskListCategory);
      case TaskListCategory.upcoming:
        taskList = _taskRepository.getTaskList(event.taskListCategory);
      case TaskListCategory.all:
        taskList = _taskRepository.getTaskList(event.taskListCategory);
    }

    emit(HomeGetTaskListSuccess(taskListCategory: event.taskListCategory, taskList: taskList));
  }

  FutureOr<void> _onHomeTaskCreated(HomeTaskCreated event, Emitter<HomeState> emit) async {
    Task createdTask = await _taskRepository.add(event.task);
    emit(HomeCreateTaskSuccess(createdTask: createdTask));
  }

  FutureOr<void> _onHomeTaskCompleted(HomeTaskCompleted event, Emitter<HomeState> emit) {
    _taskRepository.remove(event.task.id!);
    List<Task> taskList = _taskRepository.getTaskList(event.taskListCategory ?? TaskListCategory.all);

    emit(HomeCompleteTaskSuccess(taskListCategory: event.taskListCategory, taskList: taskList));
  }



  FutureOr<void> _onHomeTaskSearched(HomeTaskSearched event, Emitter<HomeState> emit) {
    List<Task> taskList = _taskRepository.searchTaskList(event.searchedString);
    emit(HomeSearchTaskSuccess(taskList: taskList));
  }
}
