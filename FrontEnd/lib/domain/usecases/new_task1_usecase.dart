// lib/domain/usecases/get_all_tasks_usecase.dart

import 'package:se121_giupviec_app/domain/entities/location.dart';
import 'package:se121_giupviec_app/domain/entities/taskType.dart';

import 'package:se121_giupviec_app/domain/repository/newTask1_repository.dart';

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

  Future<Location> execute3(int userId) async {
    return await repository.getMyDefaultLocation(userId);
  }

  Future<List<Location>> execute4(int userId) async {
    return await repository.getMyLocation(userId);
  }
}
