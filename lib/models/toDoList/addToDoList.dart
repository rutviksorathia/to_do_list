import 'package:hive/hive.dart';

class AddToDoList {
  String id;
  String title;
  String description;
  int time;
  DateTime createdDate;

  AddToDoList({
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

Future<void> addTodoList({required AddToDoList addingToDo}) async {
  final shoppingBox = Hive.box('toDoList');

  shoppingBox.add(addingToDo.toMap());
}
