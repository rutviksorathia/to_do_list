import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TodoUpsertViewModel extends BaseViewModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<String> time = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  String? selectedTime;

  Future<void> handleBaseCurrencyChange(String? value) async {
    if (value == null) return;
    selectedTime = value;
    notifyListeners();
  }
}
