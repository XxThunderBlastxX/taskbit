import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme.dart';

extension ErrorBanner on BuildContext {
  void errorBanner(String message, {int? statusCode}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        elevation: 12,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        content: statusCode == null
            ? Text(
                'Error: $message',
                style: AppTheme.theme.textTheme.labelSmall!.copyWith(
                  color: Colors.white,
                ),
              )
            : Text(
                'Error: $statusCode \n$message',
                style: AppTheme.theme.textTheme.labelSmall!.copyWith(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
