import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';
import 'package:se121_giupviec_app/domain/entities/loveTasker.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/entities/tasker_info.dart';
import '../../../../../domain/entities/task.dart';

abstract class LoveTaskersState extends Equatable {
  const LoveTaskersState();

  @override
  List<Object> get props => [];
}

class LoveTaskersInitial extends LoveTaskersState {}

class LoveTaskersLoading extends LoveTaskersState {}

class LoveTaskersSuccess extends LoveTaskersState {
  final List<LoveTasker> loveTaskers;
  final List<BlockTasker> blockTaskers;
  const LoveTaskersSuccess(this.loveTaskers, this.blockTaskers);

  @override
  List<Object> get props => [loveTaskers];
}

class LoveTaskersError extends LoveTaskersState {
  final String message;

  const LoveTaskersError(this.message);

  @override
  List<Object> get props => [message];
}
