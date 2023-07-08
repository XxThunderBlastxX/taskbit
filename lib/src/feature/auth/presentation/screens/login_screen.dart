import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/common/widgets/widgets.dart';
import '../../../../app/router/router.dart';
import '../../../../app/theme/theme.dart';
import '../provider/login_notifier.dart';
import '../states/login_state.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  Future<void> onClickSignIn(WidgetRef ref) async {
    await ref.read(loginNotifierProvider.notifier).signInUser();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      loginNotifierProvider,
      (previous, next) {
        if (next is LoginLoading) {
          showDialog(
            context: context,
            builder: (context) => StyledAlertDialog(
              child: const CircularProgressIndicator(),
            ),
          );
        } else if (next is LoginError) {
          context.pop();
          context.styledSnackbar(
            next.failure.message,
            statusCode: next.failure.code,
          );
        } else if (next is LoginSuccess) {
          context.pop();
          context.replace(AppRouterPath.tasks);
        }
      },
    );

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
