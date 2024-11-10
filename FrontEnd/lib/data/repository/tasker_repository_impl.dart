import 'package:se121_giupviec_app/data/datasources/tasker_remote_datasource.dart';
import 'package:se121_giupviec_app/data/models/taskType_model.dart';
import 'package:se121_giupviec_app/domain/entities/tasker_info.dart';
import 'package:se121_giupviec_app/domain/repository/tasker_repository.dart';

import '../../domain/entities/response.dart';

class TaskerRepositoryImpl implements TaskerRepository {
  final TaskerRemoteDataSourceImpl remoteDataSource;

  TaskerRepositoryImpl(this.remoteDataSource);

  @override
  Future<TaskerInfo> getATasker(int userId, int taskerId) async {
    return await remoteDataSource.getATasker(userId, taskerId);
  }

  @override
  Future<List<TasktypeModel>> getTaskTypeList() async {
    return await remoteDataSource.getTaskTypeList();
  }

  @override
  Future<Response> editATasker(
      int taskerId,
      String name,
      String email,
      String phoneNumber,
      String avatar,
      String introduction,
      String taskList) async {
    return await remoteDataSource.editATasker(
        taskerId, name, email, phoneNumber, avatar, introduction, taskList);
  }
}
