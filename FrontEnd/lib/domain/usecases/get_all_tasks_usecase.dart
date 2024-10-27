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
}
