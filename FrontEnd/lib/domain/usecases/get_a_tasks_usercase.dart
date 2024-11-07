// lib/domain/usecases/get_all_tasks_usecase.dart
import 'dart:io';

import 'package:se121_giupviec_app/domain/entities/location.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/repository/a_task_repository.dart';

import '../entities/task.dart';

class GetATasksUsecase {
  final ATaskRepository repository;

  GetATasksUsecase(this.repository);

  Future<Task> execute(int taskId) async {
    return await repository.getATasks(taskId);
  }

  Future<List<TaskerList>> execute2(int taskId) async {
    return await repository.getTaskerList(taskId);
  }

  deleteTask(int taskId, int cancelCode) async {
    return await repository.deleteTask(taskId, cancelCode);
  }

  fishishTask(int taskId) async {
    return await repository.finishTask(taskId);
  }

  Future<void> updateTaskerStatus(int taskerListId, String status) async {
    return await repository.updateTaskerStatus(taskerListId, status);
  }

  Future<void> editTask(
      int taskId, DateTime? time, int? locationId, String? note) {
    return repository.editTask(taskId, time, locationId, note);
  }

  Future<Location> getdflocation(int userId) async {
    return await repository.getdflocation(userId);
  }

  Future<List<Location>> getalllocation(int userId) async {
    return await repository.getalllocation(userId);
  }

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
      String? image4) async {
    return await repository.review(TaskId, taskerId, star, userId, taskerId,
        content, image1, image2, image3, image4);
  }

  Future<void> taskercanccel(int taskerId, int taskId) async {
    return await repository.taskercanccel(taskerId, taskId);
  }

  Future<String> pushImage(File file) async {
    return await repository.pushImage(file);
  }
}
