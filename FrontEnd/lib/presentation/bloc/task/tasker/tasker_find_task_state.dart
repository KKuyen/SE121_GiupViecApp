// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/taskType.dart';
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
  final List<TaskType> taskTypeList;
  const TaskerFindTaskSuccess(
    this.findTasks,
    this.taskTypeList,
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
