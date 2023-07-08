import 'package:equatable/equatable.dart';
import 'package:taskbit/src/app/error/error.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginError extends LoginState {
  final Failure failure;

  LoginError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
