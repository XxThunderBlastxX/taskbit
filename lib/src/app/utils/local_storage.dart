import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final localStorageProvider = Provider<LocalStorage>((ref) {
  return LocalStorage(pref: ref.watch(sharedPreferencesProvider));
});

class LocalStorage {
  final SharedPreferences _pref;

  LocalStorage({required SharedPreferences pref}) : _pref = pref;

  Future<void> write({required String key, required String value}) async {
    await _pref.setString(key, value);
  }

  String? read({required String key}) {
    return _pref.getString(key);
  }

  Future<void> delete({required String key}) async {
    await _pref.remove(key);
  }

  bool containsKey({required String key}) {
    return _pref.containsKey(key);
  }
}
