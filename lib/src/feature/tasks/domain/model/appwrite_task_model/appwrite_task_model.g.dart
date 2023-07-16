// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appwrite_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppwriteTaskModel _$$_AppwriteTaskModelFromJson(Map<String, dynamic> json) =>
    _$_AppwriteTaskModel(
      $id: json[r'$id'] as String,
      $collectionId: json[r'$collectionId'] as String,
      $databaseId: json[r'$databaseId'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
      category: $enumDecode(_$TaskCategoryEnumMap, json['category']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_AppwriteTaskModelToJson(
        _$_AppwriteTaskModel instance) =>
    <String, dynamic>{
      r'$id': instance.$id,
      r'$collectionId': instance.$collectionId,
      r'$databaseId': instance.$databaseId,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'category': _$TaskCategoryEnumMap[instance.category]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$TaskCategoryEnumMap = {
  TaskCategory.personal: 'personal',
  TaskCategory.work: 'work',
  TaskCategory.others: 'others',
};
