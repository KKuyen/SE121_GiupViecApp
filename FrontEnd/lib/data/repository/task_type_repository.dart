import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/domain/entities/taskType.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/task_type_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/task_type_remote_datasourse.dart';

class TaskTypeRepositoryImpl implements TaskTypeRepository {
  final TaskTypeRemoteDatasource remoteDataSource;

  TaskTypeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TaskType>> getAllTasksType() async {
    return await remoteDataSource.getAllTasksType();
  }
}
