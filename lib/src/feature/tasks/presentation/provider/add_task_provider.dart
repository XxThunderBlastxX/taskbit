import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/utils/gen_id.dart';
import '../../../../provider/global_providers.dart';
import '../../../auth/domain/model/user/user.dart';
import '../../data/repository/task_repository.dart';
import '../../domain/model/task_model/task_model.dart';
import '../state/add_task.dart';

final addTaskProvider =
    StateNotifierProvider.autoDispose<AddTask, AddTaskState>(
  (ref) => AddTask(
      taskRepository: ref.watch(taskRepositoryProvider),
      localUser: ref.watch(localUserProvider),
      generateId: ref.watch(generateIdProvider)),
);

class AddTask extends StateNotifier<AddTaskState> {
  final TaskRepository _taskRepository;
  final UserModel? _localUser;
  final GenerateId _generateId;

  AddTask({
    required TaskRepository taskRepository,
    required UserModel? localUser,
    required GenerateId generateId,
  })  : _taskRepository = taskRepository,
        _localUser = localUser,
        _generateId = generateId,
        super(AddTaskInitial());

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  Future<void> createTask() async {
    state = AddTaskLoading();
    final res = await _taskRepository.createTask(
      task: TaskModel(
        id: _generateId.generateId(),
        userId: _localUser!.id,
        title: titleController.text,
        description: descriptionController.text,
        isComplete: false,
        category: TaskCategory.personal,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    res.fold(
      (task) {
        state = AddTaskSuccess(task: task);
      },
      (failure) =>
          state = AddTaskFailure(message: failure.message, code: failure.code),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }
}
