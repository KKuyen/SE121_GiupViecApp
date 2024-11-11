import 'package:se121_giupviec_app/data/datasources/allNotification_remote-datasource.dart';
import 'package:se121_giupviec_app/data/datasources/allReview_remote_datasource.dart';
import 'package:se121_giupviec_app/domain/entities/notification.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';
import 'package:se121_giupviec_app/domain/repository/allReview_repository.dart';
import 'package:se121_giupviec_app/domain/repository/all_notificaiton_repository.dart';

class AllNotificationRepositoryImpl implements AllNotificaitonRepository {
  final AllNotificationRemoteDatasource remoteDataSource;

  AllNotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Notification>> getAllNotication(int userId) async {
    return await remoteDataSource.getAllNotication(userId);
  }

  @override
  Future<void> deleteANotification(int notificationId) async {
    return await remoteDataSource.deleteANotification(notificationId);
  }

  @override
  Future<void> addANotification(
      int userId, String header, String content, String image) async {
    return await remoteDataSource.addANotification(
        userId, header, content, image);
  }
}
