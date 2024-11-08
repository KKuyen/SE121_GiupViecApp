// lib/domain/usecases/get_all_tasks_usecase.dart
import '../entities/task.dart';
import '../repository/task_repository.dart';

class GetAllTasksUseCase {
  final TaskRepository repository;

  GetAllTasksUseCase(this.repository);

  Future<List<Task>> execute(int userId) async {
    return await repository.getTS1Tasks(userId);
  }

  Future<List<Task>> execute2(int userId) async {
    return await repository.getTS2Tasks(userId);
  }

  Future<List<Task>> execute3(int userId) async {
    return await repository.getTS3Tasks(userId);
  }

  Future<List<Task>> execute4(int userId) async {
    return await repository.getTS4Tasks(userId);
  }

  Future<List<Task>> taskerexecute(int userId) async {
    return await repository.TaskergetTS1Tasks(userId);
  }

  Future<List<Task>> taskerexecute2(int userId) async {
    return await repository.TaskergetTS2Tasks(userId);
  }

  Future<List<Task>> taskerexecute3(int userId) async {
    return await repository.TaskergetTS3Tasks(userId);
  }

  Future<List<Task>> taskerexecute4(int userId) async {
    return await repository.TaskergetTS4Tasks(userId);
  }

  Future<List<Task>> taskerfindtask(int taskerId) async {
    return await repository.taskerFindTask(taskerId);
  }

  Future<void> applyTask(int taskerId, int taskId) async {
    return await repository.applyTask(taskerId, taskId);
  }
}
