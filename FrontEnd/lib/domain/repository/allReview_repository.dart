// lib/domain/repository/task_repository.dart
import 'package:se121_giupviec_app/domain/entities/review.dart';

abstract class AllReviewRepository {
  Future<List<Review>> getAllReviews(int taskerId);
  Future<Review> getAReviews(int taskerId, int taskId);
}
