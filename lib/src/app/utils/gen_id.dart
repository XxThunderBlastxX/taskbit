import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final generateIdProvider = Provider.autoDispose<GenerateId>(
  (ref) => GenerateId(uuid: const Uuid()),
);

class GenerateId {
  final Uuid _uuid;

  GenerateId({required Uuid uuid}) : _uuid = uuid;

  String generateId() {
    final String id = _uuid.v4().replaceAll('-', '');
    return id;
  }
}
