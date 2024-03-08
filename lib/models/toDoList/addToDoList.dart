import 'package:hive/hive.dart';

class AddToDoList {
  String id;
  String title;
  String description;
  String status;
  int time;

  DateTime? createdDate;

  AddToDoList({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.time,
    this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'time': time,
      'createdDate': createdDate,
    };
  }
}

Future<void> addTodoList({required AddToDoList addingToDo}) async {
  final shoppingBox = Hive.box('toDoList');

  shoppingBox.add(addingToDo.toMap());
}
