import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/task_repository.dart';
import '../../domain/model/task_model/task_model.dart';

// final taskProvider = StateNotifierProvider.autoDispose<TaskProvider, TaskState>(
//   (ref) => TaskProvider(
//     taskRepository: ref.watch(taskRepositoryProvider),
//   ),
// );

final taskProvider = StateProvider<List<TaskModel>>((ref) => []);

final getAllTaskListProvider = FutureProvider.autoDispose((ref) async {
  final taskRepository = ref.watch(taskRepositoryProvider);
  final res = await taskRepository.getAllTasks();
  return res;
});

// class TaskProvider extends StateNotifier<List<TaskModel>> {
//   final TaskRepository _taskRepository;
//
//   TaskProvider({
//     required TaskRepository taskRepository,
//   })  : _taskRepository = taskRepository,
//         super([]);
//
//   Future<void> getTasks() async {
//     final res = await _taskRepository.getAllTasks();
//   }
// }
