import 'package:hive/hive.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';

class DeleteToDoList {
  String id;

  DeleteToDoList({
    required this.id,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
      };
}

Future<void> deleteTodoList({required ToDo deleteToDo}) async {
  final shoppingBox = Hive.box('toDoList');

  shoppingBox.delete(deleteToDo.id);
}
