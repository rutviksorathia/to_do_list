import 'package:to_do_list/ui/views/to_do_list/to_do_list_viewmodel.dart';

class ToDoList {
  String id;
  String title;
  String description;
  ToDoStatus status;
  int timer;
  DateTime createdDate;

  ToDoList({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.timer,
    required this.createdDate,
  });

  factory ToDoList.fromMap(Map<dynamic, dynamic> map) {
    return ToDoList(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: ToDoStatus.created,
      timer: map['time'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
    );
  }
}
