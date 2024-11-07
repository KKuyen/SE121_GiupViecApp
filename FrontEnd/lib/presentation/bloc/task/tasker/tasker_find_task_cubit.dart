// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_find_task_state.dart';
import '../../../../domain/usecases/get_all_tasks_usecase.dart';

class TaskerFindTaskCubit extends Cubit<TaskerFindTaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;

  TaskerFindTaskCubit({required this.getAllTasksUseCase})
      : super(TaskerFindTaskInitial());

  Future<void> getFindTasks(int taskerId) async {
    emit(TaskerFindTaskLoading());
    try {
      print("chay vao cubit");
      final findTasks = await getAllTasksUseCase.taskerfindtask(taskerId);

      emit(TaskerFindTaskSuccess(
        findTasks,
      ));
    } catch (e) {
      emit(TaskerFindTaskError(e.toString()));
    }
  }

  Future<void> applyTask(int taskerId, int taskId) async {
    final currentState = state as TaskerFindTaskSuccess;

    try {
      print("chay vao cubit");
      await getAllTasksUseCase.applyTask(taskerId, taskId);
    } catch (e) {
      emit(TaskerFindTaskError(e.toString()));
    }
  }
}
