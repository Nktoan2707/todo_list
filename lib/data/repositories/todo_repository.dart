import 'package:intl/intl.dart';
import 'package:todo_list/common/constants.dart';
import 'package:todo_list/data/models/domain/todo.dart';
import 'package:todo_list/services/local_notification_service.dart';

class TodoRepository {
  List<Todo> localList = List.empty(growable: true);
  late final LocalNotificationService localNotificationService;

  TodoRepository(){
    localNotificationService = LocalNotificationService();
    localNotificationService.requestIOSPermissions();
    localNotificationService.initializeNotification();
  }

  Future<Todo> add(Todo task) async {
    task.id = localList.length;
    localList.add(task);

    DateFormat format = DateFormat("hh:mm a");
    DateTime hourMinutes = format.parse(task.dueTime!);

    localNotificationService.scheduledNotification(hourMinutes.hour, hourMinutes.minute, task);
    return localList[localList.indexOf(task)];
  }

  void remove(int id) {
    Todo toRemoveTask = localList.firstWhere((element) => element.id == id);

    localNotificationService.cancelNotification(toRemoveTask);
    localList.remove(toRemoveTask);
  }

  List<Todo> getTaskList(TaskListCategory taskListCategory) {
    List<Todo> result = List<Todo>.empty(growable: true);

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

  List<Todo> searchTaskList(String searchString) {
    List<Todo> result = localList.where((task) =>
      task.title!.toLowerCase().contains(searchString.toLowerCase()) || task.note!.toLowerCase().contains(searchString.toLowerCase())
    ).toList();
    return result;
  }

  void dispose(){
    localNotificationService.dispose();
  }
}
