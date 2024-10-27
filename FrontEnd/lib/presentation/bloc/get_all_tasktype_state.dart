// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/taskType.dart';
import '../../../domain/entities/task.dart';

abstract class TaskTypeState extends Equatable {
  const TaskTypeState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskTypeState {}

class TaskLoading extends TaskTypeState {}

class TaskSuccess extends TaskTypeState {
  final List<TaskType> tasks;

  const TaskSuccess(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskError extends TaskTypeState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}
