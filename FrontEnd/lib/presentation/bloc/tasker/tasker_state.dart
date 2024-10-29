// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import '../../../../../domain/entities/task.dart';

abstract class TaskerState extends Equatable {
  const TaskerState();

  @override
  List<Object> get props => [];
}

class TaskerInitial extends TaskerState {}

class TaskerLoading extends TaskerState {}

class TaskerSuccess extends TaskerState {
  final List<TaskerList> tasker;

  const TaskerSuccess(this.tasker);

  @override
  List<Object> get props => [tasker];
}

class TaskerError extends TaskerState {
  final String message;

  const TaskerError(this.message);

  @override
  List<Object> get props => [message];
}
