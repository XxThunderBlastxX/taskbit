import 'package:go_router/go_router.dart';

import '../../feature/auth/presentation/screens/login_screen.dart';
import '../../feature/redirect/presentation/screens/redirect_screen.dart';
import '../../feature/tasks/presentation/tasks_screen.dart';

class AppRouterName {
  static const String auth = 'auth';
  static const String tasks = 'tasks';
}

class AppRouterPath {
  static const String auth = '/auth';
  static const String tasks = '/tasks';
  static const String redirect = '/';
}

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRouterPath.redirect,
    routes: [
      GoRoute(
        path: AppRouterPath.auth,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRouterPath.tasks,
        builder: (context, state) => const TasksScreen(),
      ),
      GoRoute(
        path: AppRouterPath.redirect,
        builder: (context, state) => const RedirectScreen(),
      ),
    ],
  );
}
