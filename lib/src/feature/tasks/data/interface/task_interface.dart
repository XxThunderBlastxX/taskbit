import 'package:appwrite/models.dart' as models;
import 'package:dartz/dartz.dart';

import '../../../../app/error/error.dart';
import '../../domain/model/task_model/task_model.dart';

abstract class ITask {
  Future<Either<models.Document, Failure>> createTask(
      {required TaskModel task});

  Future<Either<models.Document, Failure>> updateTask({
    required String docId,
    required TaskModel task,
  });

  Future<Either<models.Document, Failure>> setCompleteTask({
    required String docId,
  });

  Future<Either<models.DocumentList, Failure>> getAllTasks();
}
