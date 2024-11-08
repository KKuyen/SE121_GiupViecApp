// lib/domain/repository/task_repository.dart

import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTS1Tasks(int userId);
  Future<List<Task>> getTS2Tasks(int userId);
  Future<List<Task>> getTS3Tasks(int userId);
  Future<List<Task>> getTS4Tasks(int userId);
  Future<List<Task>> TaskergetTS1Tasks(int userId);
  Future<List<Task>> TaskergetTS2Tasks(int userId);
  Future<List<Task>> TaskergetTS3Tasks(int userId);
  Future<List<Task>> TaskergetTS4Tasks(int userId);
  Future<List<Task>> taskerFindTask(int taskerId);
  Future<void> applyTask(int taskerId, int taskId);
}
