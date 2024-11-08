// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';

import 'package:se121_giupviec_app/domain/usecases/get_all_reviews_usercase.dart';

import 'package:se121_giupviec_app/presentation/bloc/review/aReview_state.dart';

class AReviewCubit extends Cubit<AReviewState> {
  final GetAllReviewsUsercase getAReviewsUsercase;

  AReviewCubit({required this.getAReviewsUsercase}) : super(AReviewInitial());

  Future<void> getAReviews(int taskerId, int taskId) async {
    emit(AReviewLoading());
    try {
      print("chay vao Acubit");

      final Review review =
          (await getAReviewsUsercase.execute2(taskerId, taskId));

      emit(AReviewSuccess(review));
    } catch (e) {
      emit(AReviewError(e.toString()));
    }
  }
}
