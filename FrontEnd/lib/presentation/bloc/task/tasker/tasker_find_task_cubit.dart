// lib/presentation/cubit/task_cubit.dart
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/taskType.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasker_usercase.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_find_task_state.dart';
import '../../../../domain/usecases/get_all_tasks_usecase.dart';

class TaskerFindTaskCubit extends Cubit<TaskerFindTaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  final GetATaskerUsercase getATaskerUsercase;
  TaskerFindTaskCubit(
      {required this.getAllTasksUseCase, required this.getATaskerUsercase})
      : super(TaskerFindTaskInitial());

  Future<void> getFindTasks(int taskerId, List<int>? taskTypes,
      DateTime? fromDate, DateTime? toDate) async {
    emit(TaskerFindTaskLoading());
    try {
      print("chay vao cubit");
      if (taskTypes == []) taskTypes = null;

      final findTasks = await getAllTasksUseCase.taskerfindtask(
          taskerId, taskTypes, fromDate, toDate);

      final List<TaskType> taskTypeList = (await getATaskerUsercase.execute2());
      emit(TaskerFindTaskSuccess(findTasks, taskTypeList));
    } catch (e) {
      emit(TaskerFindTaskError(e.toString()));
    }
  }

  Future<void> getNoTask() async {
    emit(TaskerFindTaskLoading());
    try {
      final List<TaskType> taskTypeList = (await getATaskerUsercase.execute2());
      emit(TaskerFindTaskSuccess(null, taskTypeList));
    } catch (e) {
      emit(TaskerFindTaskError(e.toString()));
    }
  }

  Future<void> applyTask(int taskerId, int taskId) async {
    final currentState = state as TaskerFindTaskSuccess;
    currentState.findTasks?.removeWhere((task) => task.id == taskId);
    emit(TaskerFindTaskLoading());
    try {
      print("chay vao cubit");
      await getAllTasksUseCase.applyTask(taskerId, taskId);
      emit(TaskerFindTaskSuccess(
          currentState.findTasks, currentState.taskTypeList));
    } catch (e) {
      emit(TaskerFindTaskError(e.toString()));
    }
  }

  Future<void> loading(int deleteTask) async {
    emit(TaskerFindTaskLoading());
    final currentState = state as TaskerFindTaskSuccess;
    currentState.findTasks?.removeWhere((task) => task.id == deleteTask);

    try {
      emit(TaskerFindTaskSuccess(
          currentState.findTasks, currentState.taskTypeList));
    } catch (e) {
      emit(TaskerFindTaskError(e.toString()));
    }
  }
}
