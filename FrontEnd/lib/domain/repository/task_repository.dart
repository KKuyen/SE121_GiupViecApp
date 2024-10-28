// lib/domain/repository/task_repository.dart

import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTS1Tasks(int userId);
  Future<List<Task>> getTS2Tasks(int userId);
  Future<List<Task>> getTS3Tasks(int userId);
  Future<List<Task>> getTS4Tasks(int userId);
}
