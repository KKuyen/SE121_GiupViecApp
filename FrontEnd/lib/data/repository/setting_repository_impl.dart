import 'package:se121_giupviec_app/data/datasources/setting_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/data/models/setting_model.dart';
import 'package:se121_giupviec_app/data/models/simpleRes_model.dart';

import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/domain/repository/setting_repository.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingRemoteDatasource remoteDataSource;

  SettingRepositoryImpl(this.remoteDataSource);

  @override
  Future<SimpleResModel> changePassword(
      int userId, String oldPassword, String newPassword) async {
    return await remoteDataSource.changePassword(
        userId, oldPassword, newPassword);
  }

  @override
  Future<SettingModel> getSetting(int userId) async {
    return await remoteDataSource.getSetting(userId);
  }

  @override
  Future<void> setting(int userId, bool autoAcceptStatus, bool loveTaskerOnly,
      int upperStar) async {
    await remoteDataSource.setting(
        userId, autoAcceptStatus, loveTaskerOnly, upperStar);
  }
}
