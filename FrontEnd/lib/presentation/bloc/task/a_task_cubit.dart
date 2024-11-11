// lib/presentation/cubit/task_cubit.dart
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/location.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasks_usercase.dart';

import 'package:se121_giupviec_app/presentation/bloc/task/a_task_state.dart';

class ATaskCubit extends Cubit<ATaskState> {
  final GetATasksUsecase getATasksUsercase;

  ATaskCubit({required this.getATasksUsercase}) : super(ATaskInitial());

  Future<void> getATasks(int taskId, int userId) async {
    emit(ATaskLoading());
    try {
      print("chay vao Acubit");
      final task = await getATasksUsercase.execute(taskId);
      final List<TaskerList> taskerList =
          await getATasksUsercase.execute2(taskId);
      final Location dfLocation =
          (await getATasksUsercase.getdflocation(userId));
      final List<Location> Mylocations =
          await getATasksUsercase.getalllocation(userId);

      emit(ATaskSuccess(task, taskerList, dfLocation, Mylocations));
    } catch (e) {
      emit(ATaskError(e.toString()));
    }
  }

  Future<void> getATasks2(int taskId, int userId) async {
    emit(ATaskLoading());
    try {
      print("chay vao Acubit");
      final task = await getATasksUsercase.execute(taskId);
      final List<TaskerList> taskerList =
          await getATasksUsercase.execute2(taskId);

      emit(ATaskSuccess(task, taskerList, null, null));
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
    emit(ATaskLoading());
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

  Future<void> taskercanccel(int taskerId, int taskId) async {
    try {
      print("chay vao Acubit");
      await getATasksUsercase.taskercanccel(taskerId, taskId);
    } catch (e) {
      emit(ATaskError(e.toString()));
    }
  }

  Future<void> editTask(
      int taskId, DateTime? time, int? locationId, String? note) async {
    print("vao roi 2");
    final currentState = state as ATaskSuccess;
    emit(ATaskLoading());

    try {
      getATasksUsercase.editTask(taskId, time, locationId, note);
      emit(ATaskSuccess(currentState.task, currentState.taskerList,
          currentState.dfLocation, currentState.Mylocations));
    } catch (e) {
      emit(ATaskError(e.toString()));
    }
  }

  Future<void> review(
      int TaskId,
      int taskerId,
      int star,
      int userId,
      int taskTypeId,
      String content,
      String? image1,
      String? image2,
      String? image3,
      String? image4) async {
    try {
      getATasksUsercase.review(TaskId, taskerId, star, userId, taskerId,
          content, image1, image2, image3, image4);
    } catch (e) {
      emit(ATaskError(e.toString()));
    }
  }

  Future<String> pushImage(File file) {
    return getATasksUsercase.pushImage(file);
  }
}
