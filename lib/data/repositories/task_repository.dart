import 'package:intl/intl.dart';
import 'package:todo_list/common/constants.dart';
import 'package:todo_list/data/models/domain/task.dart';

class TaskRepository {
  List<Task> localList = List.empty(growable: true);

  Task add(Task task) {
    task.id = localList.length;
    localList.add(task);

    return localList[localList.indexOf(task)];
  }

  void remove(int id) {
    Task toRemoveTask = localList.firstWhere((element) => element.id == id);
    localList.remove(toRemoveTask);
  }

  List<Task> getTaskList(TaskListCategory taskListCategory) {
    List<Task> result = List<Task>.empty(growable: true);

    DateTime nowTime = DateTime.now();
    DateFormat format = DateFormat("M/d/yyyy hh:mm a");

    switch (taskListCategory) {
      case TaskListCategory.today:
        result = localList.where((element) {
          DateTime taskTime = format.parse("${element.date!} ${element.dueTime!}");
          return taskTime.difference(nowTime).inDays == 0;
        }).toList();
      case TaskListCategory.upcoming:
        result = localList.where((element) {
          DateTime taskTime = format.parse("${element.date!} ${element.dueTime!}");
          return taskTime.isAfter(nowTime);
        }).toList();
      case TaskListCategory.all:
        result = localList.toList();
    }

    return result;
  }

  List<Task> searchTaskList(String searchString) {
    List<Task> result = List<Task>.empty(growable: true);


    return result;
  }
}
