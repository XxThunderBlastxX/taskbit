import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/task_repository.dart';
import '../../domain/model/appwrite_task_model/appwrite_task_model.dart';

final getDocumentListProvider = FutureProvider<DocumentList>((ref) async {
  final taskRepository = ref.watch(taskRepositoryProvider);
  final res = await taskRepository.getAllTasks();

  return res.fold(
    (docList) => docList,
    (failure) => DocumentList(
      total: 0,
      documents: [],
    ),
  );
});

final taskNotifierProvider =
    StateNotifierProvider<TaskProvider, List<AppwriteTaskModel>>(
  (ref) => TaskProvider(taskRepository: ref.watch(taskRepositoryProvider)),
);

class TaskProvider extends StateNotifier<List<AppwriteTaskModel>> {
  final TaskRepository _taskRepository;

  TaskProvider({
    required TaskRepository taskRepository,
  })  : _taskRepository = taskRepository,
        super([]);

  void addTaskList(List<AppwriteTaskModel> taskList) {
    state = taskList;
  }

  void addTask(AppwriteTaskModel task) {
    state = [...state, task];
  }

  void removeTask(AppwriteTaskModel task) {
    state = state.where((e) => e.$id != task.$id).toList();
  }

  void setTaskComplete(AppwriteTaskModel task) {
    state = state.map((appwriteTaskModel) {
      if (appwriteTaskModel.$id == task.$id) {
        return appwriteTaskModel.copyWith(isCompleted: task.isCompleted);
      }
      return appwriteTaskModel;
    }).toList();
  }
}
