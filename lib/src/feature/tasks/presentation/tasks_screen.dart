import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taskbit/src/app/common/widgets/styled_container.dart';
import 'package:taskbit/src/feature/tasks/domain/model/task_model/task_model.dart';

import '../../../app/common/utils/random_avatar.dart';
import '../../../app/common/widgets/styled_text_field.dart';
import '../../../app/theme/theme.dart';
import '../../../provider/global_providers.dart';
import '../data/repository/task_repository.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    final avatar = ref.watch(
      randomAvatarProvider(localUser?.name ?? 'Anonymous'),
    );
    final taskRepository = ref.watch(taskRepositoryProvider);

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
                text: '\n${localUser?.name}',
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Today\'s Tasks',
                    style: AppTheme.theme.textTheme.labelMedium,
                    children: [
                      TextSpan(
                        text: '\nWednesday, 2 Jun',
                        style: AppTheme.theme.textTheme.labelSmall!.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                StyledContainer(
                  backgroundColor: AppTheme.kPinkColor,
                  onTap: () => showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    isScrollControlled: true,
                    clipBehavior: Clip.antiAlias,
                    builder: (context) {
                      return SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Text(
                                  'Add New Task to list',
                                  style: AppTheme.theme.textTheme.labelMedium,
                                ),
                              ),
                              Divider(
                                indent: 0.06.sw,
                                endIndent: 0.06.sw,
                              ),
                              Text(
                                'Task Name',
                                style: AppTheme.theme.textTheme.labelSmall,
                              ),
                              StyledTextField(
                                hintText: 'Enter task name',
                              ),
                              16.verticalSpace,
                              Text(
                                'Description',
                                style: AppTheme.theme.textTheme.labelSmall,
                              ),
                              StyledTextField(
                                hintText: 'Enter Description of your task',
                                maxLines: 4,
                                keyboardType: TextInputType.multiline,
                              ),
                              16.verticalSpace,
                              Text(
                                'Category',
                                style: AppTheme.theme.textTheme.labelSmall,
                              ),
                              Row(
                                children: [
                                  Wrap(
                                    children: [
                                      Radio(
                                        toggleable: true,
                                        value: TaskCategory.personal,
                                        groupValue: TaskCategory.personal,
                                        onChanged: (value) {
                                          print(value);
                                        },
                                      ),
                                      Text(
                                        'Personal',
                                        style:
                                            AppTheme.theme.textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  StyledContainer(
                                    backgroundColor: AppTheme.kPurpleColor,
                                    clickable: true,
                                    onTap: () => context.pop(),
                                    child: const Center(
                                      child: Text('Cancel'),
                                    ),
                                  ),
                                  StyledContainer(
                                    backgroundColor: AppTheme.kLightBlueColor,
                                    clickable: true,
                                    onTap: () {},
                                    child: const Center(
                                      child: Text('Add'),
                                    ),
                                  ),
                                ],
                              ),
                              16.verticalSpace,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  clickable: true,
                  height: 45.h,
                  width: 115.w,
                  child: Center(
                    child: Text(
                      '+ New Task',
                      style: AppTheme.theme.textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
