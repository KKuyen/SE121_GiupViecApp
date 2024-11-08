// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/data/models/setting_model.dart';
import 'package:se121_giupviec_app/domain/usecases/Setting_usecaces.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/get_all_task_state.dart';
import '../../../../domain/usecases/get_all_tasks_usecase.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  final SettingUsecaces SettingUsecase;

  TaskCubit({required this.getAllTasksUseCase, required this.SettingUsecase})
      : super(TaskInitial());
  Future<SettingModel> Success(int userId) async {
    try {
      final SettingModel settingModel =
          (await SettingUsecase.getSetting(userId));

      return settingModel;
    } catch (e) {
      return Future.error(
          e); // Ensure a value is returned or an error is thrown
    }
  }

  Future<void> getAllTasks(int userId) async {
    emit(TaskLoading());
    try {
      print("chay vao cubit");
      final TS1tasks = await getAllTasksUseCase.execute(userId);
      final TS2tasks = await getAllTasksUseCase.execute2(userId);
      final TS3tasks = await getAllTasksUseCase.execute3(userId);
      final TS4tasks = await getAllTasksUseCase.execute4(userId);
      final SettingModel settingModel =
          (await SettingUsecase.getSetting(userId));

      emit(TaskSuccess(TS1tasks, TS2tasks, TS3tasks, TS4tasks, settingModel));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> getTS1Tasks(int userId) async {
    emit(TaskLoading());
    try {
      final TS1tasks = await getAllTasksUseCase.execute(userId);
      final SettingModel settingModel =
          (await SettingUsecase.getSetting(userId));
      emit(TaskSuccess(TS1tasks, const [], const [], const [], settingModel));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> getTS2Tasks(int userId) async {
    final currentState = state as TaskSuccess;
    emit(TaskLoading());

    try {
      final TS2tasks = await getAllTasksUseCase.execute2(userId);
      emit(TaskSuccess(currentState.TS1tasks, TS2tasks, currentState.TS3tasks,
          currentState.TS4tasks, currentState.setting));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> getTS3Tasks(int userId) async {
    final currentState = state as TaskSuccess;
    emit(TaskLoading());
    try {
      final TS3tasks = await getAllTasksUseCase.execute3(userId);
      emit(TaskSuccess(currentState.TS1tasks, currentState.TS2tasks, TS3tasks,
          currentState.TS4tasks, currentState.setting));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> getTS4Tasks(int userId) async {
    final currentState = state as TaskSuccess;
    emit(TaskLoading());
    try {
      final TS4tasks = await getAllTasksUseCase.execute4(userId);
      emit(TaskSuccess(currentState.TS1tasks, currentState.TS2tasks,
          currentState.TS3tasks, TS4tasks, currentState.setting));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> Loading() async {
    emit(TaskLoading());
  }
}
