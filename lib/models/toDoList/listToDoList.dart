import 'package:hive/hive.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';

Future<List<ToDo>> getToDoList() async {
  final shoppingBox = Hive.box('toDoList');

  await shoppingBox.get('toDoList');

  Map<dynamic, dynamic> map = shoppingBox.toMap();

  return map.entries.map((entry) => ToDo.fromMap(entry.value)).toList();
}
