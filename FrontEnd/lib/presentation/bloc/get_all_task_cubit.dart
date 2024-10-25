// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/presentation/bloc/get_all_task_state.dart';
import '../../../domain/usecases/get_all_tasks_usecase.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;

  TaskCubit({required this.getAllTasksUseCase}) : super(TaskInitial());

  Future<void> getAllTasks(int userId) async {
    emit(TaskLoading());
    try {
      final tasks = await getAllTasksUseCase.execute(userId);
      emit(TaskSuccess(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
