// lib/domain/repository/task_repository.dart
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';

import '../entities/task.dart';

abstract class AllReviewRepository {
  Future<List<Review>> getAllReviews(int taskerId);
}
