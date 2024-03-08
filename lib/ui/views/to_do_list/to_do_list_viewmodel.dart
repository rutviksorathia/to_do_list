import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/models/toDoList/addToDoList.dart';
import 'package:to_do_list/models/toDoList/listToDoList.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';
import 'package:to_do_list/ui/utils/extensions/p_utils.dart';

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

  Future<void> addData() async {
    String id = getRandomString(10);
    try {
      addTodoList(
        addingToDo: AddToDoList(
          id: id,
          title: nameController.text,
          description: numberController.text,
          status: ToDoStatus.created.toString(),
          time: 0,
        ),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<ToDoList> toDoList = [];

  Future<void> fetchData() async {
    toDoList = await getToDoList();

    notifyListeners();
  }
}
