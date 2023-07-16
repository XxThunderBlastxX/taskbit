import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taskbit/src/app/theme/theme.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

enum TaskCategory { personal, work, others }

extension TaskCategoryColor on TaskCategory {
  Color get taskCategoryColor {
    switch (this) {
      case TaskCategory.personal:
        return AppTheme.kBlueColor;
      case TaskCategory.work:
        return AppTheme.kPurpleColor;
      case TaskCategory.others:
        return AppTheme.kPinkColor;
    }
  }
}

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String userId,
    required String title,
    required String description,
    required bool isCompleted,
    required TaskCategory category,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
