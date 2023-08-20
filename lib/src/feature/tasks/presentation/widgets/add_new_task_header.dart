import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../app/common/widgets/styled_container.dart';
import '../../../../app/theme/theme.dart';
import 'add_new_task.dart';

class AddNewTaskHeader extends ConsumerWidget {
  const AddNewTaskHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: 'Today\'s Tasks',
            style: AppTheme.theme.textTheme.labelMedium,
            children: [
              TextSpan(
                text:
                    '\n${DateFormat('EEEEE', 'en_US').format(DateTime.now())}, ${DateFormat('dd MMM', 'en_US').format(DateTime.now())}',
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
            enableDrag: true,
            clipBehavior: Clip.antiAlias,
            builder: (context) => DraggableScrollableSheet(
              expand: false,
              snap: true,
              snapSizes: const [0.6, 0.8, 1],
              initialChildSize: 0.6,
              maxChildSize: 1,
              minChildSize: 0.58,
              snapAnimationDuration: const Duration(milliseconds: 380),
              builder: (context, scrollController) => SingleChildScrollView(
                controller: scrollController,
                child: const AddNewTaskScreen(),
              ),
            ),
          ),
          clickable: true,
          height: 45.h,
          width: 120.w,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                '+ New Task',
                style: AppTheme.theme.textTheme.labelSmall!.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
