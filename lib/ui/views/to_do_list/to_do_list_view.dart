import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/ui/views/to_do_list/to_do_list_viewmodel.dart';
import 'package:to_do_list/ui/views/to_do_upsert/to_do_upsert_view.dart';

class ToDoListView extends StatelessWidget {
  const ToDoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ToDoListViewModel>.reactive(
      viewModelBuilder: () => ToDoListViewModel(),
      onViewModelReady: (model) {
        // model.fetchTodos();
      },
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
                    const Text(
                      'To Do List',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C3AED),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            const TodoUpsertView(),
                            useRootNavigator: true,
                            isScrollControlled: true,
                          );
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // ...model.toDoList.map(
                //   (e) => const TodoListItem(),
                // ),
                const TodoListItem(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE3E3E3),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                'Grocery Shopping',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 5),
          const Divider(
            color: Color(0xFFF1F1F1),
            height: 1,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Text(
                '12th July 2021',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7B7B7B),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: Color(0xFF2563EB),
                        ),
                        SizedBox(width: 3),
                        Text(
                          '04:25',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Created',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFD97706),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
