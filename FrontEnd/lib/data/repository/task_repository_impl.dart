import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';

import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDatasource remoteDataSource;

  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Task>> getTS1Tasks(int userId) async {
    return await remoteDataSource.getTS1Tasks(userId);
  }

  @override
  Future<List<Task>> getTS2Tasks(int userId) async {
    return await remoteDataSource.getTS2Tasks(userId);
  }

  @override
  Future<List<Task>> getTS3Tasks(int userId) async {
    return await remoteDataSource.getTS3Tasks(userId);
  }

  @override
  Future<List<Task>> getTS4Tasks(int userId) async {
    return await remoteDataSource.getTS4Tasks(userId);
  }

  @override
  Future<List<Task>> TaskergetTS1Tasks(int userId) async {
    return await remoteDataSource.TaskergetTS1Tasks(userId);
  }

  @override
  Future<List<Task>> TaskergetTS2Tasks(int userId) async {
    return await remoteDataSource.TaskergetTS2Tasks(userId);
  }

  @override
  Future<List<Task>> TaskergetTS3Tasks(int userId) async {
    return await remoteDataSource.TaskergetTS3Tasks(userId);
  }

  @override
  Future<List<Task>> TaskergetTS4Tasks(int userId) async {
    return await remoteDataSource.TaskergetTS4Tasks(userId);
  }

  @override
  Future<List<Task>> taskerFindTask(int taskerId) async {
    return await remoteDataSource.taskerFindTask(taskerId);
  }

  @override
  Future<void> applyTask(int taskerId, int taskId) async {
    return await remoteDataSource.applyTask(taskerId, taskId);
  }
}
