import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final envProvider = Provider.family<String, String>(
  name: "envProvider",
  (ref, key) {
    return dotenv.get(key, fallback: '');
  },
);
