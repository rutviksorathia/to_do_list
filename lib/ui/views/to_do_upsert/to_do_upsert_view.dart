import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';
import 'package:to_do_list/ui/views/to_do_upsert/to_do_upsert_viewmodel.dart';

class TodoUpsertView extends StatelessWidget {
  final bool isEditMode;
  final ToDo? toDo;
  final int? index;

  const TodoUpsertView({
    super.key,
    this.isEditMode = false,
    this.toDo,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoUpsertViewModel>.reactive(
      viewModelBuilder: () => TodoUpsertViewModel(
        toDo: toDo,
        index: index,
      ),
      onViewModelReady: (model) {},
      builder: (context, model, child) {
        return IntrinsicHeight(
          child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8),
            decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(
                smoothness: 1.0,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    height: 5,
                    width: 80,
                    decoration: ShapeDecoration(
                      color: Colors.grey.shade200,
                      shape: SmoothRectangleBorder(
                        smoothness: 1,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isEditMode ? 'Edit Todo' : 'Add ToDo',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: Get.back,
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(thickness: 1),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Title',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: ShapeDecoration(
                          shape: SmoothRectangleBorder(
                            smoothness: 1,
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: model.titleController,
                          decoration: const InputDecoration(
                            hintText: 'Title goes here...',
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: model.descriptionController,
                        maxLines: 8,
                        minLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Start typing here...',
                          contentPadding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Select Time',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<int>(
                        value: model.selectedTime,
                        icon: const Icon(Icons.arrow_drop_down),
                        items: model.time.map((t) {
                          return DropdownMenuItem<int>(
                            value: t,
                            child: Text(
                              '${t.toString()} Minutes',
                            ),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            model.handleBaseCurrencyChange(value),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: isEditMode
                        ? () => model.updateToDoDetails()
                        : () => model.addToDoDetails(),
                    child: Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        shape: SmoothRectangleBorder(
                          smoothness: 1.0,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: const Color(0xFF7C3AED),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            isEditMode ? 'Update' : 'Add task',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50)
              ],
            ),
          ),
        );
      },
    );
  }
}
