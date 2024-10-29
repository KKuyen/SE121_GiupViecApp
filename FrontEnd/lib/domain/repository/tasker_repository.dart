// lib/domain/repository/task_repository.dart

import 'package:se121_giupviec_app/domain/entities/tasker.dart';

import '../entities/task.dart';

abstract class TaskerRepository {
  Future<Tasker> getATasker(int userId);
}
