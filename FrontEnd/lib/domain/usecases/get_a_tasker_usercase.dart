// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/domain/entities/tasker.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/repository/a_task_repository.dart';
import 'package:se121_giupviec_app/domain/repository/tasker_repository.dart';

import '../entities/task.dart';
import '../repository/task_repository.dart';

class GetATaskerUsercase {
  final TaskerRepository repository;

  GetATaskerUsercase(this.repository);

  Future<Tasker> execute(int userId) async {
    return await repository.getATasker(userId);
  }
}
