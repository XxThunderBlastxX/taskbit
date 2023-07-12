import 'package:appwrite/appwrite.dart';

import '../interface/task_interface.dart';

class TaskRepository extends ITask {
  late final Databases _database;

  TaskRepository({required Databases database}) {
    _database = database;
  }

  @override
  createTask() {
    try {
      // _database.createDocument(
      //     databaseId: databaseId,
      //     collectionId: collectionId,
      //     documentId: documentId,
      //     data: data);
    } catch (e) {}
  }

  @override
  getAllTasks() {
    // TODO: implement getAllTasks
    throw UnimplementedError();
  }

  @override
  setCompleteTask() {
    // TODO: implement setCompleteTask
    throw UnimplementedError();
  }

  @override
  updateTask() {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
