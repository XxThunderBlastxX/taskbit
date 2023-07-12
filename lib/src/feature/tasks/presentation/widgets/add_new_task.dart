import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/common/widgets/styled_container.dart';
import '../../../../app/common/widgets/styled_text_field.dart';
import '../../../../app/theme/theme.dart';
import '../../domain/model/task_model/task_model.dart';

class AddNewTaskScreen extends ConsumerStatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  ConsumerState createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends ConsumerState<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
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
                      style: AppTheme.theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
  }
}
