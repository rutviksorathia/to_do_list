import 'package:to_do_list/ui/views/to_do_details/to_do_details_viewmodel.dart';

class ToDo {
  String id;
  String title;
  String description;
  ToDoStatus status;
  int time;
  DateTime createdDate;

  ToDo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.time,
    required this.createdDate,
  });

  factory ToDo.fromMap(Map<dynamic, dynamic> map) {
    return ToDo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: ToDoStatus.values.firstWhere((e) => e.name == map['status'],
          orElse: () => ToDoStatus.created),
      time: map['time'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
    );
  }
}
