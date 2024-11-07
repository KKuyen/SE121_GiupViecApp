// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/domain/entities/review.dart';
import 'package:se121_giupviec_app/domain/repository/allReview_repository.dart';

class GetAllReviewsUsercase {
  final AllReviewRepository repository;

  GetAllReviewsUsercase(this.repository);

  Future<List<Review>> execute(int taskerId) async {
    return await repository.getAllReviews(taskerId);
  }

  Future<Review> execute2(int taskerId, int taskId) async {
    return await repository.getAReviews(taskerId, taskId);
  }
}
