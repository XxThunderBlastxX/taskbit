import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskbit/src/feature/tasks/presentation/widgets/task_tile.dart';

import '../../tasks/domain/model/task_model/task_model.dart';
import '../../tasks/presentation/provider/tasks_provider.dart';

class OnProgressTab extends ConsumerWidget {
  const OnProgressTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskNotifierProvider);

    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return TaskTile(
          title: taskList[index].title,
          description: taskList[index].description,
          category: taskList[index].category.name,
          backgroundColor: taskList[index].category.taskCategoryColor,
        );
      },
    );
  }
}
