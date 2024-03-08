import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';
import 'package:to_do_list/ui/views/to_do_upsert/to_do_upsert_view.dart';

class TodoDetailsViewModel extends BaseViewModel {
  ToDo toDo;
  int index;

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
      final shoppingBox = Hive.box('toDoList');

      shoppingBox.getAt(index);
      Map<dynamic, dynamic> map = shoppingBox.toMap();
      toDo = ToDo.fromMap(map[index]);

      notifyListeners();
    }
  }
}
