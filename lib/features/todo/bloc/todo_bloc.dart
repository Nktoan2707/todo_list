import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/common/constants.dart';
import 'package:todo_list/data/models/domain/todo.dart';
import 'package:todo_list/data/repositories/todo_repository.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _taskRepository;

  TodoBloc({required taskRepository})
      : _taskRepository = taskRepository,
        super(const TodoInitial()) {
    on<TodoListFetched>(_onHomeTaskListFetched);
    on<TodoCreated>(_onHomeTaskCreated);
    on<TodoCompleted>(_onHomeTaskCompleted);
    on<TodoSearched>(_onHomeTaskSearched);
  }

  FutureOr<void> _onHomeTaskListFetched(
      TodoListFetched event, Emitter<TodoState> emit) {

    List<Todo> taskList = List<Todo>.empty();

    switch (event.taskListCategory) {
      case TaskListCategory.today:
        taskList = _taskRepository.getTaskList(event.taskListCategory);
      case TaskListCategory.upcoming:
        taskList = _taskRepository.getTaskList(event.taskListCategory);
      case TaskListCategory.all:
        taskList = _taskRepository.getTaskList(event.taskListCategory);
    }

    emit(TodoFetchSuccess(taskListCategory: event.taskListCategory, taskList: taskList));
  }

  FutureOr<void> _onHomeTaskCreated(TodoCreated event, Emitter<TodoState> emit) async {
    Todo createdTask = await _taskRepository.add(event.task);
    emit(TodoCreateSuccess(createdTask: createdTask));
  }

  FutureOr<void> _onHomeTaskCompleted(TodoCompleted event, Emitter<TodoState> emit) {
    _taskRepository.remove(event.task.id!);
    List<Todo> taskList = _taskRepository.getTaskList(event.taskListCategory ?? TaskListCategory.all);

    emit(TodoCompleteSuccess(taskListCategory: event.taskListCategory, taskList: taskList));
  }



  FutureOr<void> _onHomeTaskSearched(TodoSearched event, Emitter<TodoState> emit) {
    List<Todo> taskList = _taskRepository.searchTaskList(event.searchedString);
    emit(TodoSearchSuccess(taskList: taskList));
  }
}
