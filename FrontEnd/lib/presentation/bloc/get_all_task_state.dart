// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final List<Task> TS1tasks;
  final List<Task> TS2tasks;

  const TaskSuccess(this.TS1tasks, this.TS2tasks);

  @override
  List<Object> get props => [TS1tasks, TS2tasks];
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}
