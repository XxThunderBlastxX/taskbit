import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../tasks/presentation/provider/tasks_provider.dart';

class OnProgressTab extends ConsumerWidget {
  const OnProgressTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskNotifierProvider);

    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(taskList[index].title),
          subtitle: Text(taskList[index].description),
        );
      },
    );
  }
}
