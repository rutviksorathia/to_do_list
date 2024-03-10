import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/models/toDoList/deleteToList.dart';
import 'package:to_do_list/models/toDoList/listToDoList.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';
import 'package:to_do_list/ui/views/login/login_view.dart';
import 'package:to_do_list/ui/views/to_do_details/to_do_details_view.dart';
import 'package:to_do_list/ui/views/to_do_upsert/to_do_upsert_view.dart';

class ToDoListViewModel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController searchTextController = TextEditingController();

  final shoppingBox = Hive.box('toDoList');

  ToDoListViewModel() {
    searchTextController.addListener(fetchToDoSearchData);
  }

  ToDo? addingDat;

  List<ToDo> toDoList = [];

  Future<void> fetchToDoList() async {
    try {
      setBusyForObject(fetchToDoList, true);
      toDoList = await getToDoList();
    } finally {
      setBusyForObject(fetchToDoList, false);
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
      fetchToDoList();
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
      fetchToDoList();
    }
  }

  void handleLogoutButtonTap() async {
    final auth = FirebaseAuth.instance;
    await auth.signOut().then((value) {
      Get.offAll(
        () => const LoginView(isLogin: true),
      );
    });
  }

  Future<void> fetchToDoSearchData() async {
    List<ToDo> searchList = toDoList.where((element) {
      return element.title
          .toLowerCase()
          .contains(searchTextController.text.toLowerCase());
    }).toList();

    if (searchTextController.text.isEmpty) {
      fetchToDoList();
    } else {
      print('hello');
      toDoList = searchList;
    }

    notifyListeners();
  }

  Future<void> handleDeleteToDoButtonTap(int index) async {
    Get.defaultDialog(
      title: 'Delete',
      middleText: 'Are you sure you want to delete?',
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await deleteTodoList(index: index);
            fetchToDoList();
            Get.back();
          },
          child: const Text('Delete'),
        ),
      ],
    );
    notifyListeners();
  }
}
