// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/repository/a_task_repository.dart';

import '../entities/task.dart';
import '../repository/task_repository.dart';

class GetATasksUsecase {
  final ATaskRepository repository;

  GetATasksUsecase(this.repository);

  Future<Task> execute(int taskId) async {
    return await repository.getATasks(taskId);
  }

  Future<List<TaskerList>> execute2(int taskId) async {
    return await repository.getTaskerList(taskId);
  }

  deleteTask(int taskId, int cancelCode) async {
    return await repository.deleteTask(taskId, cancelCode);
  }

  fishishTask(int taskId) async {
    return await repository.finishTask(taskId);
  }
}
