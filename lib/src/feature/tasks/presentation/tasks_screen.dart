import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/common/utils/random_avatar.dart';
import '../../../app/common/widgets/widgets.dart';
import '../../../app/error/error.dart';
import '../../../app/theme/theme.dart';
import '../../../provider/global_providers.dart';
import '../domain/state/add_task.dart';
import 'provider/add_task_provider.dart';
import 'widgets/add_new_task_header.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    final avatar = ref.watch(
      randomAvatarProvider(localUser?.name ?? 'Anonymous'),
    );

    ref.listen(addTaskProvider, (previous, next) {
      if (next is AddTaskLoading) {
        showDialog(
          context: context,
          builder: (context) => StyledAlertDialog(
            child: const CircularProgressIndicator(),
          ),
        );
      } else if (next is AddTaskFailure) {
        context.pop();
        context.errorBanner(
          next.message,
          statusCode: next.code,
        );
      } else if (next is AddTaskSuccess) {
        context.pop();
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundColor: Colors.black87,
          child: Padding(
            padding: const EdgeInsets.all(3.5),
            child: avatar,
          ),
        ),
        leadingWidth: 80.w,
        title: RichText(
          text: TextSpan(
            text: 'Hello,',
            style: AppTheme.theme.textTheme.labelSmall!.copyWith(
              color: Colors.black54,
              fontSize: 13.sp,
            ),
            children: [
              TextSpan(
                text: '\n${localUser!.name}',
                style: AppTheme.theme.textTheme.labelSmall!,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 8.h,
        ),
        child: const Column(
          children: [
            AddNewTaskHeader(),
          ],
        ),
      ),
    );
  }
}
