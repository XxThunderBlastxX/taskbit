import 'package:equatable/equatable.dart';

import '../../domain/model/task_model/task_model.dart';

abstract class TaskState extends Equatable {}

class TaskInitialState extends TaskState {
  final List<TaskModel>? taskList;

  TaskInitialState({this.taskList});

  @override
  List<Object?> get props => [taskList];
}

class TaskLoadingState extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskSuccessState extends TaskState {
  final List<TaskModel>? taskList;

  TaskSuccessState({this.taskList});

  @override
  List<Object?> get props => [taskList];
}

class TaskFailureState extends TaskState {
  final String message;
  final int? code;

  TaskFailureState({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}
