import 'package:se121_giupviec_app/data/datasources/tasker_remote_datasource.dart';
import 'package:se121_giupviec_app/data/models/taskType_model.dart';
import 'package:se121_giupviec_app/domain/entities/tasker_info.dart';
import 'package:se121_giupviec_app/domain/repository/tasker_repository.dart';

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
}
