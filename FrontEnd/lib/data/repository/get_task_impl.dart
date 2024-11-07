import 'dart:io';

import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/domain/entities/location.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/repository/a_task_repository.dart';

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

  @override
  Future<Location> getdflocation(int userId) async {
    print("repository dflocation");
    print(remoteDataSource.getdflocation(userId));
    return await remoteDataSource.getdflocation(userId);
  }

  @override
  Future<List<Location>> getalllocation(int userId) async {
    return await remoteDataSource.getalllocation(userId);
  }

  @override
  Future<void> review(
      int taskId,
      int taskerId,
      int star,
      int userId,
      int taskTypeId,
      String content,
      String? image1,
      String? image2,
      String? image3,
      String? image4) async {
    return await remoteDataSource.review(taskId, taskerId, star, userId,
        taskerId, content, image1, image2, image3, image4);
  }

  @override
  Future<void> taskercanccel(int taskerId, int taskId) async {
    return await remoteDataSource.taskercancel(taskerId, taskId);
  }

  @override
  Future<String> pushImage(File file) async {
    return await remoteDataSource.pushImage(file);
  }
}
