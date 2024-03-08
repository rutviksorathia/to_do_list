import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/to_do_list/to_do_list_viewmodel.dart';

class ToDoListView extends StatelessWidget {
  const ToDoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ToDoListViewModel>.reactive(
      viewModelBuilder: () => ToDoListViewModel(),
      builder: (context, viewModel, child) {
        return const Scaffold();
      },
    );
  }
}
