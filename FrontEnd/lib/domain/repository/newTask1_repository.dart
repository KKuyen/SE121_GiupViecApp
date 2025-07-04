// lib/domain/repository/task_repository.dart

import 'package:se121_giupviec_app/data/models/taskType_model.dart';
import 'package:se121_giupviec_app/domain/entities/location.dart';
import 'package:se121_giupviec_app/domain/entities/voucher.dart';

abstract class Newtask1Repository {
  Future<TasktypeModel> getATaskType(int TaskTypeId);
  Future<void> createTask(
      int userId,
      int taskTypeId,
      DateTime time,
      int locationId,
      String note,
      int myvoucherId,
      int voucherId,
      String paymentMethod,
      List<Map<String, dynamic>> addPriceDetail);
  Future<List<Location>> getMyLocation(int userId);
  Future<Location?> getMyDefaultLocation(int userId);
  Future<List<Voucher>> getAvailableVoucherList(int userId, int taskTypeId);
}
