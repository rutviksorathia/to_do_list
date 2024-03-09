import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/models/toDoList/deleteToList.dart';
import 'package:to_do_list/models/toDoList/listToDoList.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';
import 'package:to_do_list/ui/views/to_do_details/to_do_details_view.dart';
import 'package:to_do_list/ui/views/to_do_upsert/to_do_upsert_view.dart';

class ToDoListViewModel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController searchTextController = TextEditingController();

  final shoppingBox = Hive.box('toDoList');

  ToDoListViewModel() {
    searchTextController.addListener(fetchSearchData);
  }

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

  Future<void> handleToDoListItemTap(ToDo toDo, int index) async {
    var result = await Get.to<bool>(
      () => TodoDetailsView(
        toDo: toDo,
        index: index,
      ),
    );

    if (result != null && result == true) {
      fetchData();
    }
  }

  Future<void> fetchSearchData() async {
    List<ToDo> searchList = toDoList.where((element) {
      return element.title
          .toLowerCase()
          .contains(searchTextController.text.toLowerCase());
    }).toList();

    if (searchTextController.text.isEmpty) {
      fetchData();
    } else {
      toDoList = searchList;
    }

    notifyListeners();
  }

  Future<void> handleDeleteToDoButtonTap(int index) async {
    await deleteTodoList(index: index);

    fetchData();
    notifyListeners();
  }
}
