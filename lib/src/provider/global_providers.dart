import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientProvider = Provider<Client>(
  name: "appwriteClientProvider",
  (ref) {
    return Client()
      ..setEndpoint('')
      ..setProject('')
      ..setSelfSigned(status: true);
  },
);

final accountProvider = Provider<Account>(
  name: "appwriteAccountProvider",
  (ref) {
    return Account(ref.watch(clientProvider));
  },
);
