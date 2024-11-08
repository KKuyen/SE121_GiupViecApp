import 'package:se121_giupviec_app/data/datasources/allReview_remote_datasource.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';
import 'package:se121_giupviec_app/domain/repository/allReview_repository.dart';

class AllReviewRepositoryImpl implements AllReviewRepository {
  final AllReviewRemoteDatasource remoteDataSource;

  AllReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Review>> getAllReviews(int taskerId) async {
    return await remoteDataSource.getAllReviews(taskerId);
  }

  @override
  Future<Review> getAReviews(int taskerId, int taskId) async {
    return remoteDataSource.getAReviews(taskerId, taskId);
  }
}
