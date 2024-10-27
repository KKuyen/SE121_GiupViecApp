import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDatasource remoteDataSource;

  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Task>> getTS1Tasks(int taskId) async {
    return await remoteDataSource.getTS1Tasks(taskId);
  }

  @override
  Future<List<Task>> getTS2Tasks(int taskId) async {
    return await remoteDataSource.getTS2Tasks(taskId);
  }

  @override
  Future<List<Task>> getTS3Tasks(int taskId) async {
    return await remoteDataSource.getTS3Tasks(taskId);
  }

  @override
  Future<List<Task>> getTS4Tasks(int taskId) async {
    return await remoteDataSource.getTS4Tasks(taskId);
  }
}
