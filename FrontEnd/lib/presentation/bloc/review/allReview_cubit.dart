// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';

import 'package:se121_giupviec_app/domain/usecases/get_all_reviews_usercase.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/allReview_state.dart';

class allReviewCubit extends Cubit<AllReviewState> {
  final GetAllReviewsUsercase getAllReviewsUsercase;

  allReviewCubit({required this.getAllReviewsUsercase})
      : super(AllReviewInitial());

  Future<void> getAllReviews(int taskerId) async {
    emit(AllReviewLoading());
    try {
      print("chay vao Acubit");

      final List<Review> taskerList =
          (await getAllReviewsUsercase.execute(taskerId));

      emit(AllReviewSuccess(taskerList));
    } catch (e) {
      emit(AllReviewError(e.toString()));
    }
  }
}
