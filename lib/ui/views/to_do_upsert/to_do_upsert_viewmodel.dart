import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/models/toDoList/addToDoList.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';
import 'package:to_do_list/models/toDoList/updateToDoList.dart';
import 'package:to_do_list/ui/utils/extensions/p_utils.dart';

class TodoUpsertViewModel extends BaseViewModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final ToDo? toDo;
  final int? index;

  TodoUpsertViewModel({
    this.toDo,
    this.index,
  }) {
    if (toDo != null) {
      titleController.text = toDo!.title;
      descriptionController.text = toDo!.description;
      selectedTime = (toDo!.time / 60).round();
    }
  }

  List<int> time = [1, 2, 3, 4, 5];

  int selectedTime = 1;

  Future<void> handleBaseCurrencyChange(int? value) async {
    if (value == null) return;
    selectedTime = value;
    notifyListeners();
  }

  ToDo? addingDat;

  Future<void> addToDoDetails() async {
    String id = getRandomString(10);
    try {
      await addTodoList(
        addingToDo: AddToDoList(
          id: id,
          title: titleController.text,
          description: descriptionController.text,
          time: selectedTime * 60,
          createdDate: DateTime.now(),
        ),
      );

      Get.back(result: true);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateToDoDetails() async {
    if (toDo == null || index == null) return;
    try {
      updateTodoList(
          index: index!,
          updateToDo: UpdateToDoList(
            id: toDo!.id,
            title: titleController.text,
            description: descriptionController.text,
            time: selectedTime * 60,
            createdDate: DateTime.now(),
            status: toDo!.status,
          ));

      Get.back(result: true);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
