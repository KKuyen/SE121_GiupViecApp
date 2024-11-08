// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';

abstract class TaskerListState extends Equatable {
  const TaskerListState();

  @override
  List<Object> get props => [];
}

class TaskerListInitial extends TaskerListState {}

class TaskerListLoading extends TaskerListState {}

class TaskerListSuccess extends TaskerListState {
  final List<TaskerList> taskerList;

  const TaskerListSuccess(this.taskerList);

  @override
  List<Object> get props => [taskerList];
}

class TaskerListError extends TaskerListState {
  final String message;

  const TaskerListError(this.message);

  @override
  List<Object> get props => [message];
}
