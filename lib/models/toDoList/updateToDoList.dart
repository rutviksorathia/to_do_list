import 'package:hive/hive.dart';

class UpdateToDoList {
  String id;
  String title;
  String description;
  int time;
  DateTime createdDate;

  UpdateToDoList({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time,
      'createdDate': createdDate.millisecondsSinceEpoch,
    };
  }
}

Future<void> updateTodoList(
    {required UpdateToDoList updateToDo, required int index}) async {
  final shoppingBox = Hive.box('toDoList');

  shoppingBox.putAt(index, updateToDo.toMap());
}
