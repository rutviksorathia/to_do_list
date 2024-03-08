import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/ui/views/to_do_upsert/to_do_upsert_viewmodel.dart';

class TodoUpsertView extends StatelessWidget {
  final bool isEditMode;

  const TodoUpsertView({
    super.key,
    this.isEditMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoUpsertViewModel>.reactive(
      viewModelBuilder: () => TodoUpsertViewModel(),
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
                                      color: Colors.blue,
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
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
                        child: TextField(
                          controller: model.titleController,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
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
                        child: TextField(
                          controller: model.descriptionController,
                          maxLines: 6,
                          minLines: 4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButton<String>(
                        value: model.selectedTime,
                        items: model.time.map((t) {
                          return DropdownMenuItem<String>(
                            value: t,
                            child: Text(t),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            model.handleBaseCurrencyChange(value),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // model.handleUpdateButtonTap();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      shape: SmoothRectangleBorder(
                        smoothness: 1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      isEditMode ? 'Update' : 'Add',
                      style: const TextStyle(fontSize: 16),
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
