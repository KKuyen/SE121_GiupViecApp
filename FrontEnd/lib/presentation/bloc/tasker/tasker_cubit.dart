// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/response.dart';
import 'package:se121_giupviec_app/domain/entities/taskType.dart';
import 'package:se121_giupviec_app/domain/entities/tasker_info.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasker_usercase.dart';

import 'package:se121_giupviec_app/presentation/bloc/tasker/tasker_state.dart';

import '../../../domain/usecases/edit_a_tasker_profile_usecase.dart';

class TaskerCubit extends Cubit<TaskerState> {
  final GetATaskerUsercase getATaskerUsercase;
  final EditATaskerProfileUsecase editATaskerProfileUsecase;

  TaskerCubit(
      {required this.getATaskerUsercase,
      required this.editATaskerProfileUsecase})
      : super(TaskerInitial());

  Future<void> getATasker(int userId, int taskerId) async {
    emit(TaskerLoading());
    try {
      print("chay vao Acubit");

      final TaskerInfo taskerInfo =
          (await getATaskerUsercase.execute(userId, taskerId));
      final List<TaskType> taskTypeList = (await getATaskerUsercase.execute2());

      emit(TaskerSuccess(taskerInfo, taskTypeList));
    } catch (e) {
      emit(TaskerError(e.toString()));
    }
  }

  Future<void> editATaskerProfile(
      int taskerId,
      String name,
      String email,
      String phoneNumber,
      String avatar,
      String introduction,
      String taskList) async {
    emit(TaskerLoading());
    try {
      print("chay vao Acubit");

      final Response response = (await editATaskerProfileUsecase.execute(
          taskerId, name, email, phoneNumber, avatar, introduction, taskList));

      emit(TaskerResponseSuccess(response));
    } catch (e) {
      emit(TaskerError(e.toString()));
    }
  }
}
