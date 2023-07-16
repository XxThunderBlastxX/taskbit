import 'package:appwrite/models.dart' as models;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/utils/utils.dart';
import '../feature/auth/data/repository/auth_repository.dart';
import '../feature/auth/domain/model/user/user.dart';

final localUserProvider = StateProvider<UserModel?>(
  (ref) {
    final String? id = ref.watch(localStorageProvider).read(key: 'id');
    final String? email = ref.watch(localStorageProvider).read(key: 'email');
    final String? name = ref.watch(localStorageProvider).read(key: 'name');

    if (email == '' ||
        name == '' ||
        email == null ||
        name == null ||
        id == '' ||
        id == null) {
      return null;
    } else {
      return UserModel(
        id: id,
        email: email,
        name: name,
      );
    }
  },
);

final authStateProvider = FutureProvider.autoDispose<models.User?>(
  (ref) async {
    final authProvider = ref.watch(authRepositoryProvider);

    final res = await authProvider.getCurrentUser();

    return res.fold(
      (user) => user,
      (failure) => null,
    );
  },
);
