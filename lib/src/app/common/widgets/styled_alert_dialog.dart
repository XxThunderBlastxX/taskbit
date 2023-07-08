import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyledAlertDialog extends AlertDialog {
  final Widget child;

  StyledAlertDialog({
    super.key,
    required this.child,
  }) : super(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          title: Center(child: child),
          elevation: 12,
        );
}
