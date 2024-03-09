import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/models/toDoList/modelToDoList.dart';
import 'package:to_do_list/ui/utils/components/base_timer.dart';
import 'package:to_do_list/ui/views/to_do_details/to_do_details_viewmodel.dart';

class TodoDetailsView extends StatelessWidget {
  final ToDo toDo;
  final int index;
  const TodoDetailsView({
    super.key,
    required this.toDo,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoDetailsViewModel>.reactive(
      viewModelBuilder: () => TodoDetailsViewModel(
        toDo: toDo,
        index: index,
      ),
      onViewModelReady: (model) {},
      builder: ((context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 10),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await model.updateToDoDetails(model.toDo);
                              Get.back(result: true);
                            },
                            child: const Icon(
                              Icons.chevron_left,
                              size: 30,
                            ),
                          ),
                          const Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (model.toDo.status != ToDoStatus.done)
                      ElevatedButton(
                        onPressed: model.selectedStatus != ToDoStatus.done
                            ? () => model.handleEditButtonTap()
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFEF3C7),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                // const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.toDo.title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAE8FF),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            model.currentStatus.capitalizeFirst.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFFC026D3),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          model.toDo.description,
                          style: const TextStyle(
                            fontSize: 32,
                            color: Color(0xFF7C7C7C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (model.toDo.status != ToDoStatus.done)
                  BaseTimer(
                    start: model.toDo.time,
                    status: model.selectedStatus,
                    tapPlayButtonTap: (time) async {
                      model.selectedStatus = ToDoStatus.inProgress;
                      model.toDo.status = model.selectedStatus;
                      model.toDo.time = time;
                      model.updateToDoDetails(model.toDo);
                      model.notifyListeners();
                    },
                    tapStopButtonTap: (int) {
                      model.toDo.time = int;
                      model.updateToDoDetails(model.toDo);
                      model.notifyListeners();
                    },
                    tapFinishButtonTap: () {
                      model.selectedStatus = ToDoStatus.done;
                      model.toDo.status = model.selectedStatus;
                      model.toDo.time = 0;

                      model.updateToDoDetails(model.toDo);
                      model.notifyListeners();
                    },
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      color: Colors.amberAccent,
                      width: double.infinity,
                      child: const Text(
                        'Task Completed',
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      }),
    );
  }
}
