import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/error/error.dart';
import '../../../../app/utils/utils.dart';
import '../../../../provider/global_providers.dart';
import '../../../auth/domain/model/user/user.dart';
import '../../domain/model/task_model/task_model.dart';
import '../interface/task_interface.dart';

final databaseIdProvider = Provider.autoDispose<String>(
    (ref) => ref.watch(envProvider('DATABASE_ID')));
final collectionIdProvider = Provider.autoDispose<String>(
    (ref) => ref.watch(envProvider('COLLECTION_ID')));

final taskRepositoryProvider = Provider.autoDispose(
  (ref) => TaskRepository(
    database: Databases(ref.watch(clientProvider)),
    functions: Functions(ref.watch(clientProvider)),
    user: ref.watch(localUserProvider)!,
    generateId: ref.watch(generateIdProvider),
    log: ref.watch(styledLogProvider),
    databaseId: ref.watch(databaseIdProvider),
    collectionId: ref.watch(collectionIdProvider),
  ),
);

class TaskRepository extends ITask {
  late final Databases _database;
  late final Functions _functions;
  late final UserModel _user;
  late final GenerateId _generateId;
  late final StyledLog _log;
  late final String _databaseId;
  late final String _collectionId;

  TaskRepository({
    required Databases database,
    required Functions functions,
    required UserModel user,
    required GenerateId generateId,
    required StyledLog log,
    required String databaseId,
    required String collectionId,
  })  : _database = database,
        _functions = functions,
        _generateId = generateId,
        _databaseId = databaseId,
        _collectionId = collectionId,
        _log = log,
        _user = user;

  @override
  Future<Either<models.Document, Failure>> createTask({
    required TaskModel task,
  }) async {
    try {
      _log.i('Creating task 🐥');
      final res = await _database.createDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: _generateId.generateId(),
        data: task.toJson(),
      );
      _log.i('Task created 🎉');
      return Left(res);
    } on AppwriteException catch (err) {
      _log.e('Error creating task ☹ \n $err');
      return Right(Failure(message: err.message!, code: err.code!));
    } catch (err) {
      _log.e('Error creating task ☹\n $err');
      return Right(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<models.DocumentList, Failure>> getAllTasks() async {
    try {
      _log.i('Getting tasks list 🐥');
      final models.DocumentList docs = await _database.listDocuments(
          databaseId: _databaseId,
          collectionId: _collectionId,
          queries: [
            Query.equal('userId', _user.id),
          ]);

      _log.i('Successfully received tasks list 🎉');
      return Left(docs);
    } on AppwriteException catch (err) {
      _log.e('Error getting tasks ☹');
      return Right(Failure(message: err.message!, code: err.code!));
    } catch (err) {
      _log.e('Error getting tasks ☹');
      return Right(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<models.Document, Failure>> setCompleteTask({
    required String docId,
  }) async {
    try {
      _log.i('Setting task($docId) as complete 🐥');
      final models.Document doc = await _database.updateDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: docId,
        data: {
          'isComplete': true,
          'updatedAt': DateTime.now().toIso8601String().toString(),
        },
      );
      _log.i('Task($docId) set as completed 🎉');
      return Left(doc);
    } on AppwriteException catch (err) {
      return Right(Failure(message: err.message!, code: err.code!));
    } catch (err) {
      return Right(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<models.Document, Failure>> updateTask({
    required String docId,
    required TaskModel task,
  }) async {
    try {
      _log.i('Updating task($docId) 🐥');
      final models.Document doc = await _database.updateDocument(
        databaseId: _databaseId,
        collectionId: _user.id,
        documentId: docId,
        data: {
          'title': task.title,
          'description': task.description,
          'isComplete': task.isComplete,
          'updatedAt': DateTime.now().toIso8601String().toString(),
        },
      );

      _log.i('Task($docId) updated 🎉');
      return Left(doc);
    } on AppwriteException catch (err) {
      _log.e('Error updating task($docId) ☹');
      return Right(Failure(message: err.message!, code: err.code!));
    } catch (err) {
      _log.e('Error updating task($docId) ☹');
      return Right(Failure(message: err.toString()));
    }
  }
}
