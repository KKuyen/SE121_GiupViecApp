import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/repository/a_task_repository.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class ATaskRepositoryImpl implements ATaskRepository {
  final TaskRemoteDatasource remoteDataSource;

  ATaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<Task> getATasks(int taskId) async {
    return await remoteDataSource.getATask(taskId);
  }

  @override
  Future<List<TaskerList>> getTaskerList(int userId) async {
    return await remoteDataSource.getTaskerList(userId);
  }

  @override
  Future<void> deleteTask(int taskId, int cancelCode) async {
    return await remoteDataSource.deleteTask(taskId, cancelCode);
  }

  @override
  Future<void> finishTask(int taskId) async {
    return await remoteDataSource.finishTask(taskId);
  }

  @override
  Future<void> updateTaskerStatus(int taskerListId, String status) async {
    return await remoteDataSource.updateTaskerStatus(taskerListId, status);
  }

  @override
  Future<void> editTask(
      int taskId, DateTime? time, int? locationId, String? note) async {
    return await remoteDataSource.editTask(taskId, time, locationId, note);
  }
}
