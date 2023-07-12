import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/utils/local_storage.dart';
import '../feature/auth/data/repository/auth_repository.dart';
import '../feature/auth/domain/model/user/user.dart';

final clientProvider = Provider<Client>(
  name: "appwriteClientProvider",
  (ref) {
    return Client()
      ..setEndpoint(ref.read(envProvider('APPWRITE_ENDPOINT')))
      ..setProject(ref.read(envProvider('APPWRITE_PROJECT_ID')))
      ..setSelfSigned(status: true);
  },
);

final accountProvider = Provider<Account>(
  name: "appwriteAccountProvider",
  (ref) {
    return Account(ref.watch(clientProvider));
  },
);

final envProvider = Provider.family<String, String>(
  name: "envProvider",
  (ref, key) {
    return dotenv.get(key, fallback: '');
  },
);

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
