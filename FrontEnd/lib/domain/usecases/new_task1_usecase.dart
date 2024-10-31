// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/data/models/taskType_model.dart';
import 'package:se121_giupviec_app/domain/entities/taskType.dart';
import 'package:se121_giupviec_app/domain/entities/tasker_info.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/repository/a_task_repository.dart';
import 'package:se121_giupviec_app/domain/repository/newTask1_repository.dart';
import 'package:se121_giupviec_app/domain/repository/tasker_repository.dart';

import '../entities/task.dart';
import '../repository/task_repository.dart';

class NewTask1Usecase {
  final Newtask1Repository repository;

  NewTask1Usecase(this.repository);

  Future<TaskType> execute(int taskTypeId) async {
    return await repository.getATaskType(taskTypeId);
  }

  Future<void> execute2(
      int userId,
      int taskTypeId,
      DateTime time,
      int locationId,
      String note,
      int myvoucherId,
      int voucherId,
      List<Map<String, dynamic>> addPriceDetail) async {
    return await repository.createTask(userId, taskTypeId, time, locationId,
        note, myvoucherId, voucherId, addPriceDetail);
  }
}
