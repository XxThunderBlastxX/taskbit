import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskbit/src/app/common/widgets/widgets.dart';
import 'package:taskbit/src/app/theme/theme.dart';
import 'package:taskbit/src/feature/tasks/domain/model/task_model/task_model.dart';

import '../../tasks/presentation/provider/tasks_provider.dart';

class OnProgressTab extends ConsumerWidget {
  const OnProgressTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskNotifierProvider);

    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 16.w,
          ),
          child: StyledContainer(
            height: 110.h,
            backgroundColor: taskList[index].category.taskCategoryColor,
            child: ListTile(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category : ${taskList[index].category.name}',
                    style: AppTheme.theme.textTheme.labelSmall!.copyWith(
                      color: Colors.black.withOpacity(0.65),
                      fontSize: 10.6.sp,
                    ),
                  ),
                  Text(
                    taskList[index].title,
                    style: AppTheme.theme.textTheme.labelMedium,
                  ),
                ],
              ),
              subtitle: Text(
                taskList[index].description,
                style: AppTheme.theme.textTheme.labelSmall!.copyWith(
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
