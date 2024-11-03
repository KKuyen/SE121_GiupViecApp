// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasks_usercase.dart';
import 'package:se121_giupviec_app/presentation/bloc/TaskType/get_all_tasktype_state.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_state.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_state.dart';

class ATaskCubit extends Cubit<ATaskState> {
  final GetATasksUsecase getATasksUsercase;

  ATaskCubit({required this.getATasksUsercase}) : super(ATaskInitial());

  Future<void> getATasks(int taskId) async {
    emit(ATaskLoading());
    try {
      print("chay vao Acubit");
      final task = await getATasksUsercase.execute(taskId);
      final List<TaskerList> taskerList =
          await getATasksUsercase.execute2(taskId);

      emit(ATaskSuccess(task, taskerList));
    } catch (e) {
      emit(ATaskError(e.toString()));
    }
  }

  Future<void> deleteTask(int taskId, int cancelCode) async {
    emit(ATaskLoading());
    try {
      print("chay vao Acubit");
      final task = await getATasksUsercase.deleteTask(taskId, cancelCode);
    } catch (e) {
      emit(ATaskError(e.toString()));
    }
  }

  Future<void> finishTask(int taskId) async {
    try {
      print("chay vao Acubit");
      final task = await getATasksUsercase.fishishTask(taskId);
    } catch (e) {
      emit(ATaskError(e.toString()));
    }
  }

  Future<void> updateTaskerStatus(int taskerListId, String status) async {
    try {
      print("chay vao Acubit");
      await getATasksUsercase.updateTaskerStatus(taskerListId, status);
    } catch (e) {
      emit(ATaskError(e.toString()));
    }
  }

  Future<void> editTask(
      int taskId, DateTime? time, int? locationId, String? note) async {
    final currentState = state as ATaskSuccess;
    emit(ATaskLoading());

    try {
      getATasksUsercase.editTask(taskId, time, locationId, note);
      emit(ATaskSuccess(currentState.task, currentState.taskerList));
    } catch (e) {
      emit(ATaskError(e.toString()));
    }
  }
}
