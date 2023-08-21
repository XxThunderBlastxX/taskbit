import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskbit/src/app/env/env.dart';

final clientProvider = Provider<Client>(
  name: "appwriteClientProvider",
  (ref) {
    return Client()
      ..setEndpoint(Env.appwriteEndpoint)
      ..setProject(Env.appwriteProjectID)
      ..setSelfSigned(status: true);
  },
);

final accountProvider = Provider<Account>(
  name: "appwriteAccountProvider",
  (ref) {
    return Account(ref.watch(clientProvider));
  },
);

final appwriteStreamProvider = Provider(
  (ref) => Realtime(
    ref.watch(clientProvider),
  ),
);
