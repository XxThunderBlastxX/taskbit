import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../provider/provider.dart';
import '../../../auth/domain/model/user/user.dart';
import '../../data/repository/task_repository.dart';
import '../../domain/model/task_model/task_model.dart';
import '../state/add_task.dart';

final addTaskProvider =
    StateNotifierProvider.autoDispose<AddTask, AddTaskState>(
  (ref) => AddTask(
    taskRepository: ref.watch(taskRepositoryProvider),
    localUser: ref.watch(localUserProvider),
  ),
);

class AddTask extends StateNotifier<AddTaskState> {
  final TaskRepository _taskRepository;
  final UserModel? _localUser;

  AddTask({
    required TaskRepository taskRepository,
    required UserModel? localUser,
  })  : _taskRepository = taskRepository,
        _localUser = localUser,
        super(AddTaskInitial());

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  TaskCategory taskCategory = TaskCategory.personal;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> createTask() async {
    state = AddTaskLoading();
    final res = await _taskRepository.createTask(
      task: TaskModel(
        userId: _localUser!.id,
        title: titleController.text,
        description: descriptionController.text,
        isCompleted: false,
        category: taskCategory,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    res.fold(
      (task) {
        titleController.clear();
        descriptionController.clear();
        taskCategory = TaskCategory.personal;
        state = AddTaskSuccess(task: task);
      },
      (failure) => state = AddTaskFailure(
        message: failure.message,
        code: failure.code,
      ),
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
