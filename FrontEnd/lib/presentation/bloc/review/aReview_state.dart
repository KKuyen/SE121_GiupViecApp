import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';

abstract class AReviewState extends Equatable {
  const AReviewState();

  @override
  List<Object> get props => [];
}

class AReviewInitial extends AReviewState {}

class AReviewLoading extends AReviewState {}

class AReviewSuccess extends AReviewState {
  final Review review;

  const AReviewSuccess(this.review);

  @override
  List<Object> get props => [review];
}

class AReviewError extends AReviewState {
  final String message;

  const AReviewError(this.message);

  @override
  List<Object> get props => [message];
}
