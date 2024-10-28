// lib/domain/usecases/get_all_tasks_usecase.dart
import '../../entities/taskType.dart';
import '../../repository/task_type_repository.dart';

class GetAllTasksTypeUseCase {
  final TaskTypeRepository repository;

  GetAllTasksTypeUseCase(this.repository);

  Future<List<TaskType>> execute() async {
    return await repository.getAllTasksType();
  }
}
