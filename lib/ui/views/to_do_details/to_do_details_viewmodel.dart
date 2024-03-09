import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';
import 'package:to_do_list/models/toDoList/updateToDoList.dart';
import 'package:to_do_list/ui/views/to_do_upsert/to_do_upsert_view.dart';

enum ToDoStatus {
  created,
  inProgress,
  done,
}

class TodoDetailsViewModel extends BaseViewModel {
  ToDo toDo;
  int index;
  bool shouldShowEditButton = true;
  ToDoStatus selectedStatus = ToDoStatus.created;

  TodoDetailsViewModel({
    required this.toDo,
    required this.index,
  });

  String get currentStatus {
    if (toDo.time == 0) {
      selectedStatus = ToDoStatus.done;
      toDo.status = selectedStatus;
      return toDo.status.name;
    } else {
      return toDo.status.name;
    }
  }

  Future<void> handleEditButtonTap() async {
    var result = await Get.bottomSheet<bool>(
      TodoUpsertView(
        isEditMode: true,
        index: index,
        toDo: toDo,
      ),
      useRootNavigator: true,
      isScrollControlled: true,
    );

    if (result != null && result == true) {
      final shoppingBox = Hive.box('toDoList');

      shoppingBox.getAt(index);
      Map<dynamic, dynamic> map = shoppingBox.toMap();

      toDo = ToDo.fromMap(map.entries.elementAt(index).value);
      toDo.time = toDo.time;

      notifyListeners();
    }
  }

  Future<void> updateToDoDetails(ToDo toDoItem) async {
    try {
      updateTodoList(
          index: index,
          updateToDo: UpdateToDoList(
            id: toDoItem.id,
            title: toDoItem.title,
            description: toDoItem.description,
            time: toDoItem.time,
            createdDate: DateTime.now(),
            status: selectedStatus,
          ));

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
