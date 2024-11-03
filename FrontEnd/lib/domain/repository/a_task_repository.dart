// lib/domain/repository/task_repository.dart
import 'package:se121_giupviec_app/data/models/task_model.dart';
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
}
