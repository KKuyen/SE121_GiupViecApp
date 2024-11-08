import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';

abstract class AllReviewState extends Equatable {
  const AllReviewState();

  @override
  List<Object> get props => [];
}

class AllReviewInitial extends AllReviewState {}

class AllReviewLoading extends AllReviewState {}

class AllReviewSuccess extends AllReviewState {
  final List<Review> reviewLs;

  const AllReviewSuccess(this.reviewLs);

  @override
  List<Object> get props => [reviewLs];
}

class AllReviewError extends AllReviewState {
  final String message;

  const AllReviewError(this.message);

  @override
  List<Object> get props => [message];
}
