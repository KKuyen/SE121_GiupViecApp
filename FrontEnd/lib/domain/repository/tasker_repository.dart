// lib/domain/repository/task_repository.dart

import 'package:se121_giupviec_app/data/models/taskType_model.dart';
import 'package:se121_giupviec_app/domain/entities/tasker_info.dart';

import '../entities/response.dart';

abstract class TaskerRepository {
  Future<TaskerInfo> getATasker(int userId, int taskerId);
  Future<List<TasktypeModel>> getTaskTypeList();
  Future<Response> editATasker(int taskerId, String name, String email,
      String phoneNumber, String avatar, String introduction, String taskList);
}
