// lib/domain/repository/task_repository.dart
import 'package:se121_giupviec_app/data/models/task_model.dart';

import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks(int userId);
}
