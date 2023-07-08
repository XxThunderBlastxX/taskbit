import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/common/widgets/styled_container.dart';
import '../../../app/theme/theme.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  Future<void> onClickSignIn(WidgetRef ref) async {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EDEB),
      body: Center(
        child: StyledContainer(
          backgroundColor: const Color(0xFFCDB4DB),
          clickable: true,
          onTap: () => onClickSignIn(ref),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                'assets/images/g-logo.png',
                width: 42.w,
                height: 42.h,
              ),
              Text(
                'Sign in',
                style: AppTheme.theme.textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
