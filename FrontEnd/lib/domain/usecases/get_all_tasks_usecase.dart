// lib/domain/usecases/get_all_tasks_usecase.dart
import '../entities/task.dart';
import '../repository/task_repository.dart';

class GetAllTasksUseCase {
  final TaskRepository repository;

  GetAllTasksUseCase(this.repository);

  Future<List<Task>> execute(int userId) async {
    return await repository.getAllTasks(userId);
  }
}
