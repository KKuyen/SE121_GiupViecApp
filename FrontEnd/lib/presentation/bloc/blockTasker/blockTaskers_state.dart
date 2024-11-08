import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';

abstract class BlockTaskersState extends Equatable {
  const BlockTaskersState();

  @override
  List<Object> get props => [];
}

class BlockTaskersInitial extends BlockTaskersState {}

class BlockTaskersLoading extends BlockTaskersState {}

class BlockTaskersSuccess extends BlockTaskersState {
  final List<BlockTasker> blockTaskers;

  const BlockTaskersSuccess(this.blockTaskers);

  @override
  List<Object> get props => [blockTaskers];
}

class BlockTaskersError extends BlockTaskersState {
  final String message;

  const BlockTaskersError(this.message);

  @override
  List<Object> get props => [message];
}
