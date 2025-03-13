// lib/domain/repository/task_repository.dart
import 'package:se121_giupviec_app/domain/entities/notification.dart';

abstract class AllNotificaitonRepository {
  Future<List<Notification>> getAllNotication(int userId);
  Future<void> deleteANotification(int notificationId);
  Future<void> addANotification(
      int userId, String header, String content, String image);
}
