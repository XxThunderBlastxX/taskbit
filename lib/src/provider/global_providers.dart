import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return dotenv.get(key);
  },
);
