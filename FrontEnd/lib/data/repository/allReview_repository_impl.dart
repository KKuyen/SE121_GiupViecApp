import 'package:se121_giupviec_app/data/datasources/allReview_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/data/models/review_model.dart';
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/domain/repository/allReview_repository.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AllReviewRepositoryImpl implements AllReviewRepository {
  final AllReviewRemoteDatasource remoteDataSource;

  AllReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Review>> getAllReviews(int taskerId) async {
    return await remoteDataSource.getAllReviews(taskerId);
  }
}
