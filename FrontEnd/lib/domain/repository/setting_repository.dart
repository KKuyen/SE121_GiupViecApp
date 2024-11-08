// lib/domain/repository/task_repository.dart

import 'package:se121_giupviec_app/data/models/setting_model.dart';
import 'package:se121_giupviec_app/data/models/simpleRes_model.dart';

abstract class SettingRepository {
  Future<SimpleResModel> changePassword(
      int userId, String oldPassword, String newPassword);
  Future<SettingModel> getSetting(int userId);
  Future<void> setting(
      int userId, bool autoAcceptStatus, bool loveTaskerOnly, int upperStar);
}
