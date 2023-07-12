import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskbit/src/app/common/widgets/styled_container.dart';

import '../../../app/common/utils/random_avatar.dart';
import '../../../app/theme/theme.dart';
import '../../../provider/global_providers.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    final avatar = ref.watch(
      randomAvatarProvider(localUser?.name ?? 'Anonymous'),
    );

    return Scaffold(
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
                  onTap: () {},
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
