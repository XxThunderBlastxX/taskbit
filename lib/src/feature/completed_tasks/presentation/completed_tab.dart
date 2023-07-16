import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../tasks/data/repository/task_repository.dart';
import '../../tasks/domain/model/task_model/task_model.dart';
import '../../tasks/presentation/provider/tasks_provider.dart';
import '../../tasks/presentation/widgets/task_tile.dart';

class CompletedTab extends ConsumerWidget {
  const CompletedTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskNotifierProvider);

    return taskList.isEmpty
        ? const Center(child: Text('Opps You don\'t have any task yet :('))
        : ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return !taskList[index].isCompleted
                  ? const SizedBox()
                  : TaskTile(
                      title: taskList[index].title,
                      description: taskList[index].description,
                      category: taskList[index].category.name,
                      backgroundColor:
                          taskList[index].category.taskCategoryColor,
                      onChanged: (value) =>
                          ref.watch(taskRepositoryProvider).updateTask(
                                docId: taskList[index].$id,
                                task: TaskModel(
                                  userId: taskList[index].userId,
                                  title: taskList[index].title,
                                  description: taskList[index].description,
                                  isCompleted: value!,
                                  category: taskList[index].category,
                                  createdAt: taskList[index].createdAt,
                                  updatedAt: taskList[index].updatedAt,
                                ),
                              ),
                      value: taskList[index].isCompleted,
                    );
            },
          );
  }
}
