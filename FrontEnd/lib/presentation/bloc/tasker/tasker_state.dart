// lib/presentation/cubit/task_state.dart
// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/taskType.dart';

import 'package:se121_giupviec_app/domain/entities/tasker_info.dart';

import '../../../domain/entities/response.dart';

abstract class TaskerState extends Equatable {
  const TaskerState();

  @override
  List<Object> get props => [];
}

class TaskerInitial extends TaskerState {}

class TaskerLoading extends TaskerState {}

class TaskerSuccess extends TaskerState {
  final TaskerInfo tasker;
  final List<TaskType> taskTypeList;

  const TaskerSuccess(this.tasker, this.taskTypeList);

  @override
  List<Object> get props => [tasker, taskTypeList];
}

class TaskerResponseSuccess extends TaskerState {
  final Response response;

  const TaskerResponseSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class TaskerError extends TaskerState {
  final String message;

  const TaskerError(this.message);

  @override
  List<Object> get props => [message];
}
