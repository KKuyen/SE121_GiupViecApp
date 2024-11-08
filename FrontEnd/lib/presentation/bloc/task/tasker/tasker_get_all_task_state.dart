// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/task.dart';

abstract class TaskerTaskState extends Equatable {
  const TaskerTaskState();

  @override
  List<Object> get props => [];
}

class TaskerTaskInitial extends TaskerTaskState {}

class TaskerTaskLoading extends TaskerTaskState {}

class TaskerTaskSuccess extends TaskerTaskState {
  final List<Task>? TS1tasks;
  final List<Task>? TS2tasks;
  final List<Task>? TS3tasks;

  const TaskerTaskSuccess(
    this.TS1tasks,
    this.TS2tasks,
    this.TS3tasks,
  );

  @override
  List<Object> get props => [];
}

class TaskerTaskError extends TaskerTaskState {
  final String message;

  const TaskerTaskError(this.message);

  @override
  List<Object> get props => [message];
}
