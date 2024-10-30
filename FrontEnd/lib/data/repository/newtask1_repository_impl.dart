import 'package:se121_giupviec_app/data/datasources/newTask1_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/tasker_remote_datasource.dart';
import 'package:se121_giupviec_app/data/models/taskType_model.dart';
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/domain/entities/tasker_info.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/repository/a_task_repository.dart';
import 'package:se121_giupviec_app/domain/repository/newTask1_repository.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';
import 'package:se121_giupviec_app/domain/repository/tasker_repository.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class Newtask1RepositoryImpl implements Newtask1Repository {
  final NewTask1RemoteDatasource remoteDataSource;

  Newtask1RepositoryImpl(this.remoteDataSource);

  @override
  Future<TasktypeModel> getATaskType(int TaskTypeId) async {
    return await remoteDataSource.getAtTaskType(TaskTypeId);
  }
}
