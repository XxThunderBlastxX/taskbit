import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/common/widgets/widgets.dart';
import '../../../../app/theme/theme.dart';

class TaskTile extends ConsumerWidget {
  final String title;
  final String description;
  final String category;
  final Color backgroundColor;

  const TaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.category,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 16.w,
      ),
      child: StyledContainer(
        height: 110.h,
        backgroundColor: backgroundColor,
        child: ListTile(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category : $category',
                style: AppTheme.theme.textTheme.labelSmall!.copyWith(
                  color: Colors.black.withOpacity(0.65),
                  fontSize: 10.6.sp,
                ),
              ),
              Text(
                title,
                style: AppTheme.theme.textTheme.labelMedium,
              ),
            ],
          ),
          subtitle: Text(
            description,
            style: AppTheme.theme.textTheme.labelSmall!.copyWith(
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}