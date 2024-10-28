import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/repository/a_task_repository.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class ATaskRepositoryImpl implements ATaskRepository {
  final TaskRemoteDatasource remoteDataSource;

  ATaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<Task> getATasks(int taskId) async {
    return await remoteDataSource.getATask(taskId);
  }

  @override
  Future<List<TaskerList>> getTaskerList(int userId) async {
    return await remoteDataSource.getTaskerList(userId);
  }
}