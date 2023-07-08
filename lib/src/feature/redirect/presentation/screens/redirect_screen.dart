import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/router.dart';
import '../../../../provider/global_providers.dart';

class RedirectScreen extends ConsumerWidget {
  const RedirectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        authState.when(
          data: (data) => data?.email == null
              ? context.replace(AppRouterPath.auth)
              : context.replace(AppRouterPath.tasks),
          error: (err, stackTrace) => context.replace(AppRouterPath.auth),
          loading: () {},
        );
      },
    );

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
