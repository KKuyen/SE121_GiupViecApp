// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import '../../../domain/entities/task.dart';

abstract class AWState extends Equatable {
  const AWState();

  @override
  List<Object> get props => [];
}

class AWInitial extends AWState {}

class AWLoading extends AWState {}

class AWSuccess extends AWState {
  final List<TaskerList> taskerList;

  const AWSuccess(this.taskerList);

  @override
  List<Object> get props => [taskerList];
}

class AWError extends AWState {
  final String message;

  const AWError(this.message);

  @override
  List<Object> get props => [message];
}
