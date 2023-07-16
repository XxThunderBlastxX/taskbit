import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'router/router.dart';
import 'theme/theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      scaleByHeight: false,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        title: 'Taskbit',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
      ),
    );
  }
}
