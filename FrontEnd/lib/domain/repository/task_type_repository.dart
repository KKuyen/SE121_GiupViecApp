// lib/domain/repository/task_repository.dart
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/domain/entities/taskType.dart';

abstract class TaskTypeRepository {
  Future<List<TaskType>> getAllTasksType();
}
