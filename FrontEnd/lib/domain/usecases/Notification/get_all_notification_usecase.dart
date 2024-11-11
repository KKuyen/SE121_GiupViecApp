// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/domain/entities/notification.dart';
import 'package:se121_giupviec_app/domain/repository/all_notificaiton_repository.dart';

import '../../entities/taskType.dart';
import '../../repository/task_type_repository.dart';

class GetAllNotificationUseCase {
  final AllNotificaitonRepository repository;

  GetAllNotificationUseCase(this.repository);

  Future<List<Notification>> execute(int userId) async {
    return await repository.getAllNotication(userId);
  }

  Future<void> deleteANotification(int notificationId) async {
    await repository.deleteANotification(notificationId);
  }

  Future<void> addANotification(
      int userId, String header, String content, String image) async {
    await repository.addANotification(userId, header, content, image);
  }
}
