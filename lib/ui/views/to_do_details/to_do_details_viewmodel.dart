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
  bool needRefresh = false;
  ToDoStatus selectedStatus = ToDoStatus.created;

  TodoDetailsViewModel({
    required this.toDo,
    required this.index,
  });

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
      needRefresh = true;
      final shoppingBox = Hive.box('toDoList');

      shoppingBox.getAt(index);
      Map<dynamic, dynamic> map = shoppingBox.toMap();
      toDo = ToDo.fromMap(map[index]);

      notifyListeners();
    }
  }

  Future<void> updateToDoDetails() async {
    try {
      updateTodoList(
          index: index,
          updateToDo: UpdateToDoList(
            id: toDo.id,
            title: toDo.title,
            description: toDo.description,
            time: toDo.time,
            createdDate: DateTime.now(),
            status: selectedStatus,
          ));

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
