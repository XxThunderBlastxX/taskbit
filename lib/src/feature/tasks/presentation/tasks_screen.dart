import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/common/utils/random_avatar.dart';
import '../../../provider/global_providers.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    final avatar =
        ref.watch(randomAvatarProvider(localUser?.name ?? 'Anonymous'));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: CircleAvatar(
          child: avatar,
        ),
        title: const Text('Tasks'),
      ),
      body: const Center(
        child: Text('Tasks'),
      ),
    );
  }
}
