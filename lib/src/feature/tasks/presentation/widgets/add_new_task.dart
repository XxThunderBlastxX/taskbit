import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/common/widgets/styled_container.dart';
import '../../../../app/common/widgets/styled_text_field.dart';
import '../../../../app/theme/theme.dart';
import '../../domain/model/task_model/task_model.dart';
import '../provider/add_task_provider.dart';
import 'category_radio_button.dart';

class AddNewTaskScreen extends ConsumerStatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  ConsumerState createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends ConsumerState<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final addTask = ref.watch(addTaskProvider.notifier);

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
            Form(
              key: addTask.formKey,
              child: Column(
                children: [
                  Text(
                    'Task Name',
                    style: AppTheme.theme.textTheme.labelSmall,
                  ),
                  StyledTextField(
                    hintText: 'Enter task name',
                    controller: addTask.titleController,
                    focusNode: addTask.titleFocusNode,
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
                    controller: addTask.descriptionController,
                    focusNode: addTask.descriptionFocusNode,
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            Text(
              'Category',
              style: AppTheme.theme.textTheme.labelSmall,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryRadioButton(
                  label: 'Personal',
                  color: AppTheme.kBlueColor,
                  groupValue: addTask.taskCategory,
                  categoryValue: TaskCategory.personal,
                  onChanged: (value) {
                    setState(() {
                      addTask.taskCategory = value as TaskCategory;
                    });
                  },
                ),
                CategoryRadioButton(
                  label: 'Work',
                  color: AppTheme.kPurpleColor,
                  groupValue: addTask.taskCategory,
                  categoryValue: TaskCategory.work,
                  onChanged: (value) {
                    setState(() {
                      addTask.taskCategory = value as TaskCategory;
                    });
                  },
                ),
                CategoryRadioButton(
                  label: 'Others',
                  color: AppTheme.kPinkColor,
                  groupValue: addTask.taskCategory,
                  categoryValue: TaskCategory.others,
                  onChanged: (value) {
                    setState(() {
                      addTask.taskCategory = value as TaskCategory;
                    });
                  },
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
                  onTap: () {
                    if (!addTask.formKey.currentState!.validate()) return;
                    context.pop();
                    ref.watch(addTaskProvider.notifier).createTask();
                  },
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
