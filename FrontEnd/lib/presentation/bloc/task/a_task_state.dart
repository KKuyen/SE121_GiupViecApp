// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/location.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import '../../../../../domain/entities/task.dart';

abstract class ATaskState extends Equatable {
  const ATaskState();

  @override
  List<Object> get props => [];
}

class ATaskInitial extends ATaskState {}

class ATaskLoading extends ATaskState {}

class ATaskSuccess extends ATaskState {
  final Task task;
  final List<TaskerList> taskerList;
  final Location dfLocation;
  final List<Location> Mylocations;

  const ATaskSuccess(
      this.task, this.taskerList, this.dfLocation, this.Mylocations);

  @override
  List<Object> get props => [task, taskerList];
}

class ATaskError extends ATaskState {
  final String message;

  const ATaskError(this.message);

  @override
  List<Object> get props => [message];
}
