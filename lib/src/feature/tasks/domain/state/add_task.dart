import 'package:appwrite/models.dart' as models;
import 'package:equatable/equatable.dart';

abstract class AddTaskState extends Equatable {}

class AddTaskInitial extends AddTaskState {
  @override
  List<Object?> get props => [];
}

class AddTaskLoading extends AddTaskState {
  @override
  List<Object?> get props => [];
}

class AddTaskSuccess extends AddTaskState {
  final models.Document task;

  AddTaskSuccess({required this.task});

  @override
  List<Object?> get props => [task];
}

class AddTaskFailure extends AddTaskState {
  final String message;
  final int? code;

  AddTaskFailure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}
