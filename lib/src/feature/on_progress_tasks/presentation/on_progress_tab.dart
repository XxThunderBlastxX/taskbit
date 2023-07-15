import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../tasks/presentation/provider/tasks_provider.dart';

class OnProgressTab extends ConsumerWidget {
  const OnProgressTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(getAllTaskListProvider);

    return taskList.when(
      data: (tasks) => tasks.fold(
        (docList) => ListView.builder(
          itemCount: docList.documents.length,
          itemBuilder: (BuildContext context, int index) {
            final task = docList.documents[index];
            if (!task.data['isComplete']) {
              return ListTile(
                title: Text(task.data['title']),
                subtitle: Text(task.data['description']),
              );
            } else {
              return const Center(
                child: Text('No task on progress'),
              );
            }
          },
        ),
        (failure) => Center(
          child: Text(failure.message),
        ),
      ),
      error: (err, stackTrace) {
        return Center(
          child: Text(err.toString()),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
