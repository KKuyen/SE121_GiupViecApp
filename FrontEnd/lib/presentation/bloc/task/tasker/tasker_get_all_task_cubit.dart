// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_get_all_task_state.dart';
import '../../../../domain/usecases/get_all_tasks_usecase.dart';

class TaskerTaskCubit extends Cubit<TaskerTaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;

  TaskerTaskCubit({required this.getAllTasksUseCase})
      : super(TaskerTaskInitial());

  Future<void> getAllTasks(int userId) async {
    emit(TaskerTaskLoading());
    try {
      print("chay vao cubit");
      final TS1tasks = await getAllTasksUseCase.taskerexecute(userId);
      final TS2tasks = await getAllTasksUseCase.taskerexecute2(userId);
      final TS3tasks = await getAllTasksUseCase.taskerexecute3(userId);

      emit(TaskerTaskSuccess(
        TS1tasks,
        TS2tasks,
        TS3tasks,
      ));
    } catch (e) {
      emit(TaskerTaskError(e.toString()));
    }
  }

  Future<void> begin(int userId) async {
    emit(TaskerTaskLoading());
    try {
      final TS1tasks = await getAllTasksUseCase.taskerexecute(userId);

      emit(TaskerTaskSuccess(
        TS1tasks,
        const [],
        const [],
      ));
    } catch (e) {
      emit(TaskerTaskError(e.toString()));
    }
  }

  Future<void> getTS1Tasks(int userId) async {
    final currentState = state as TaskerTaskSuccess;
    emit(TaskerTaskLoading());

    try {
      final TS1tasks = await getAllTasksUseCase.taskerexecute2(userId);
      emit(TaskerTaskSuccess(
          TS1tasks, currentState.TS2tasks, currentState.TS3tasks));
    } catch (e) {
      emit(TaskerTaskError(e.toString()));
    }
  }

  Future<void> getTS2Tasks(int userId) async {
    final currentState = state as TaskerTaskSuccess;
    emit(TaskerTaskLoading());

    try {
      final TS2tasks = await getAllTasksUseCase.taskerexecute2(userId);
      emit(TaskerTaskSuccess(
          currentState.TS1tasks, TS2tasks, currentState.TS3tasks));
    } catch (e) {
      emit(TaskerTaskError(e.toString()));
    }
  }

  Future<void> getTS3Tasks(int userId) async {
    final currentState = state as TaskerTaskSuccess;
    emit(TaskerTaskLoading());
    try {
      final TS3tasks = await getAllTasksUseCase.taskerexecute3(userId);
      emit(TaskerTaskSuccess(
          currentState.TS1tasks, currentState.TS2tasks, TS3tasks));
    } catch (e) {
      emit(TaskerTaskError(e.toString()));
    }
  }

  Future<void> Loading() async {
    emit(TaskerTaskLoading());
  }
}
