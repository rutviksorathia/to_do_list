import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/models/toDoList/deleteToList.dart';
import 'package:to_do_list/models/toDoList/listToDoList.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';
import 'package:to_do_list/ui/views/to_do_details/to_do_details_view.dart';
import 'package:to_do_list/ui/views/to_do_list/to_do_list_view.dart';
import 'package:to_do_list/ui/views/to_do_upsert/to_do_upsert_view.dart';

enum ToDoStatus {
  created,
  inProgress,
  done,
}

class ToDoListViewModel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  final shoppingBox = Hive.box('toDoList');

  ToDo? addingDat;

  List<ToDo> toDoList = [];

  Future<void> fetchData() async {
    try {
      setBusyForObject(fetchData, true);
      toDoList = await getToDoList();
    } finally {
      setBusyForObject(fetchData, false);
    }
    notifyListeners();
  }

  Future<void> handleAddToDoButtonTap() async {
    var result = await Get.bottomSheet<bool>(
      const TodoUpsertView(),
      useRootNavigator: true,
      isScrollControlled: true,
    );

    if (result != null && result == true) {
      fetchData();
    }
  }

  void handleToDoListItemTap(ToDo toDo) {
    Get.to(() => TodoDetailsView(toDo: toDo));
  }

  Future<void> handleDeleteToDoButtonTap(int index) async {
    await shoppingBox.deleteAt(index);

    fetchData();
    notifyListeners();
  }
}
