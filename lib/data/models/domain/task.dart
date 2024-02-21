class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? dueTime;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.dueTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'dueTime': dueTime,
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    dueTime = json['dueTime'];
  }
}
