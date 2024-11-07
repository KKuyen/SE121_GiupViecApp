// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/task.dart';

abstract class TaskerFindTaskState extends Equatable {
  const TaskerFindTaskState();

  @override
  List<Object> get props => [];
}

class TaskerFindTaskInitial extends TaskerFindTaskState {}

class TaskerFindTaskLoading extends TaskerFindTaskState {}

class TaskerFindTaskSuccess extends TaskerFindTaskState {
  final List<Task>? findTasks;

  const TaskerFindTaskSuccess(
    this.findTasks,
  );

  @override
  List<Object> get props => [];
}

class TaskerFindTaskError extends TaskerFindTaskState {
  final String message;

  const TaskerFindTaskError(this.message);

  @override
  List<Object> get props => [message];
}
