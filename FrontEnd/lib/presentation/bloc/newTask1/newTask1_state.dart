import 'package:equatable/equatable.dart';

import 'package:se121_giupviec_app/domain/entities/taskType.dart';

abstract class NewTask1State extends Equatable {
  const NewTask1State();

  @override
  List<Object> get props => [];
}

class NewTask1Initial extends NewTask1State {}

class NewTask1Loading extends NewTask1State {}

class NewTask1Success extends NewTask1State {
  final TaskType taskType;

  const NewTask1Success(this.taskType);

  @override
  List<Object> get props => [taskType];
}

class NewTask1Execute2 extends NewTask1State {
  const NewTask1Execute2();

  @override
  List<Object> get props => [];
}

class NewTask1Error extends NewTask1State {
  final String message;

  const NewTask1Error(this.message);

  @override
  List<Object> get props => [message];
}
