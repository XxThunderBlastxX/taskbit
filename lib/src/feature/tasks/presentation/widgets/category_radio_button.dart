import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/theme.dart';
import '../../domain/model/task_model/task_model.dart';
import '../provider/add_task_provider.dart';

class CategoryRadioButton extends ConsumerStatefulWidget {
  final String label;
  final Color color;
  final TaskCategory categoryValue;
  final TaskCategory groupValue;
  final void Function(TaskCategory?)? onChanged;

  const CategoryRadioButton({
    super.key,
    required this.label,
    required this.color,
    required this.categoryValue,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  ConsumerState createState() => _CategoryRadioButtonState();
}

class _CategoryRadioButtonState extends ConsumerState<CategoryRadioButton> {
  @override
  Widget build(BuildContext context) {
    final addTask = ref.watch(addTaskProvider.notifier);
    return Expanded(
      child: RadioListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.comfortable,
        dense: false,
        title: Transform.translate(
          offset: const Offset(-18, 0),
          child: Text(
            maxLines: 1,
            widget.label,
            style: AppTheme.theme.textTheme.labelSmall!.copyWith(
              color: Colors.black87,
              fontSize: 10.8.sp,
            ),
          ),
        ),
        value: widget.categoryValue,
        groupValue: widget.groupValue,
        fillColor: MaterialStateProperty.all(widget.color),
        toggleable: true,
        // splashRadius: 20.r,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
