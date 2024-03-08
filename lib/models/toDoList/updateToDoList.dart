import 'package:hive/hive.dart';
import 'package:to_do_list/ui/views/to_do_details/to_do_details_viewmodel.dart';

class UpdateToDoList {
  String id;
  String title;
  String description;
  int time;
  DateTime createdDate;
  ToDoStatus status;

  UpdateToDoList({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.createdDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'status': status.name,
    };
  }
}

Future<void> updateTodoList(
    {required UpdateToDoList updateToDo, required int index}) async {
  final shoppingBox = Hive.box('toDoList');

  shoppingBox.putAt(index, updateToDo.toMap());
}
