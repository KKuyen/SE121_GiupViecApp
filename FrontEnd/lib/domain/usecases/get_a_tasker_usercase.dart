// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/data/models/taskType_model.dart';
import 'package:se121_giupviec_app/domain/entities/tasker_info.dart';
import 'package:se121_giupviec_app/domain/repository/tasker_repository.dart';

class GetATaskerUsercase {
  final TaskerRepository repository;

  GetATaskerUsercase(this.repository);

  Future<TaskerInfo> execute(int userId, int taskerId) async {
    return await repository.getATasker(userId, taskerId);
  }

  Future<List<TasktypeModel>> execute2() async {
    return await repository.getTaskTypeList();
  }
}
