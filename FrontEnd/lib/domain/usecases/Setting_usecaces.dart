// lib/domain/usecases/get_all_tasks_usecase.dart

import 'package:se121_giupviec_app/data/models/setting_model.dart';
import 'package:se121_giupviec_app/data/models/simpleRes_model.dart';
import 'package:se121_giupviec_app/domain/repository/setting_repository.dart';

class SettingUsecaces {
  final SettingRepository repository;

  SettingUsecaces(this.repository);

  Future<SimpleResModel> execute(
      int userId, String oldPassword, String newPassword) async {
    return await repository.changePassword(userId, oldPassword, newPassword);
  }

  Future<SettingModel> getSetting(int userId) async {
    return await repository.getSetting(userId);
  }

  Future<void> setting(int userId, bool autoAcceptStatus, bool loveTaskerOnly,
      int upperStar) async {
    await repository.setting(
        userId, autoAcceptStatus, loveTaskerOnly, upperStar);
  }
}
