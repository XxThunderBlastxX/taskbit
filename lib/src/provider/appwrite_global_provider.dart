import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskbit/src/provider/provider.dart';

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

final appwriteStreamProvider = Provider(
  (ref) => Realtime(
    ref.watch(clientProvider),
  ),
);
