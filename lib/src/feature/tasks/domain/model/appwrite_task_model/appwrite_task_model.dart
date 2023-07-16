import 'package:freezed_annotation/freezed_annotation.dart';

import '../task_model/task_model.dart';

part 'appwrite_task_model.freezed.dart';
part 'appwrite_task_model.g.dart';

@freezed
class AppwriteTaskModel with _$AppwriteTaskModel {
  const factory AppwriteTaskModel({
    required String $id,
    required String $collectionId,
    required String $databaseId,
    required String userId,
    required String title,
    required String description,
    required bool isCompleted,
    required TaskCategory category,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AppwriteTaskModel;

  factory AppwriteTaskModel.fromJson(Map<String, dynamic> json) =>
      _$AppwriteTaskModelFromJson(json);
}
