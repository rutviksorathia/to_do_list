import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/models/toDoList/addToDoList.dart';
import 'package:to_do_list/models/toDoList/listToDoList.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';
import 'package:to_do_list/ui/utils/extensions/p_utils.dart';
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

  ToDoList? addingDat;

  List<ToDoList> toDoList = [];

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
}
