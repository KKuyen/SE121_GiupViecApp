import 'package:se121_giupviec_app/data/datasources/newTask1_remote_datasource.dart';

import 'package:se121_giupviec_app/data/models/taskType_model.dart';
import 'package:se121_giupviec_app/domain/entities/location.dart';
import 'package:se121_giupviec_app/domain/entities/voucher.dart';
import 'package:se121_giupviec_app/domain/repository/newTask1_repository.dart';

class Newtask1RepositoryImpl implements Newtask1Repository {
  final NewTask1RemoteDatasource remoteDataSource;

  Newtask1RepositoryImpl(this.remoteDataSource);

  @override
  Future<TasktypeModel> getATaskType(int TaskTypeId) async {
    return await remoteDataSource.getAtTaskType(TaskTypeId);
  }

  @override
  Future<void> createTask(
      int userId,
      int taskTypeId,
      DateTime time,
      int locationId,
      String note,
      int myvoucherId,
      int voucherId,
      List<Map<String, dynamic>> addPriceDetail) async {
    return await remoteDataSource.createTask(userId, taskTypeId, time,
        locationId, note, myvoucherId, voucherId, addPriceDetail);
  }

  @override
  Future<List<Location>> getMyLocation(int userId) async {
    return await remoteDataSource.getMyLocation(userId);
  }

  @override
  Future<Location> getMyDefaultLocation(int userId) async {
    return await remoteDataSource.getMyDefaultLocation(userId);
  }

  @override
  Future<List<Voucher>> getAvailableVoucherList(
      int userId, int taskTypeId) async {
    return await remoteDataSource.getAvailableVoucherList(userId, taskTypeId);
  }
}
