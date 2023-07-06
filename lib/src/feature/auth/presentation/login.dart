import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository/auth_repository.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('LoginScreen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () =>
                  ref.read(authRepositoryProvider).signInWithGoogle(),
              child: Text('Login Button'),
            ),
            ElevatedButton(
              onPressed: () => ref.read(authRepositoryProvider).signOut(),
              child: Text('Logout Button'),
            ),
          ],
        ),
      ),
    );
  }
}
