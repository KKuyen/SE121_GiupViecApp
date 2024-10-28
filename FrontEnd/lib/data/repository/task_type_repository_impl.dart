import 'package:se121_giupviec_app/domain/entities/taskType.dart';
import '../../domain/repository/task_type_repository.dart';
import '../datasources/task_type_remote_datasourse.dart';

class TaskTypeRepositoryImpl implements TaskTypeRepository {
  final TaskTypeRemoteDatasource remoteDataSource;

  TaskTypeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TaskType>> getAllTasksType() async {
    return await remoteDataSource.getAllTasksType();
  }
}
