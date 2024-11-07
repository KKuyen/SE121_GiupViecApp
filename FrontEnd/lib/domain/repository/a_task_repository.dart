// lib/domain/repository/task_repository.dart

import 'dart:io';

import 'package:se121_giupviec_app/domain/entities/location.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';

import '../entities/task.dart';

abstract class ATaskRepository {
  Future<Task> getATasks(int taskId);
  Future<List<TaskerList>> getTaskerList(int taskId);

  Future<void> deleteTask(int taskId, int cancelCode);
  Future<void> finishTask(int taskId);
  Future<void> updateTaskerStatus(int taskerListId, String status);
  Future<void> editTask(
      int TaskId, DateTime? time, int? locationId, String? note);
  Future<Location> getdflocation(int userId);
  Future<List<Location>> getalllocation(int userId);
  Future<void> review(
      int TaskId,
      int taskerId,
      int star,
      int userId,
      int taskTypeId,
      String content,
      String? image1,
      String? image2,
      String? image3,
      String? image4);
  Future<void> taskercanccel(int taskerId, int taskId);
  Future<String> pushImage(File file);
}
