// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/data/models/setting_model.dart';
import 'package:se121_giupviec_app/data/models/simpleRes_model.dart';
import 'package:se121_giupviec_app/domain/usecases/Setting_usecaces.dart';

import 'package:se121_giupviec_app/presentation/bloc/Setting/Setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingUsecaces SettingUsecase;

  SettingCubit({required this.SettingUsecase}) : super(SettingInitial());
  Future<void> getSetting(int userId) async {
    emit(SettingLoading());
    try {
      final SettingModel setting = await SettingUsecase.getSetting(userId);

      emit(SettingSuccess(setting));
    } catch (e) {
      emit(SettingError(e.toString()));
    }
  }

  Future<void> setting(
    int userId,
    bool autoAcceptStatus,
    bool loveTaskerOnly,
    int upperStar,
  ) async {
    try {
      await SettingUsecase.setting(
          userId, autoAcceptStatus, loveTaskerOnly, upperStar);
    } catch (e) {
      emit(SettingError(e.toString()));
    }
  }

  Future<SimpleResModel> changePassword(
      int userId, String oldPassword, String newPassword) async {
    final currentState = state as SettingSuccess;
    emit(SettingLoading());
    try {
      final SimpleResModel simpleResModel =
          await SettingUsecase.execute(userId, oldPassword, newPassword);
      emit(SettingSuccess(currentState.setting));

      return simpleResModel;
    } catch (e) {
      emit(SettingError(e.toString()));
      return SimpleResModel.fromJson({"message": e.toString()});
    }
  }

  Future<void> Loading() async {
    emit(SettingLoading());
  }

  Future<SettingModel> Success(int userId) async {
    emit(SettingLoading());
    try {
      final SettingModel settingModel =
          (await SettingUsecase.getSetting(userId));

      emit(SettingSuccess(settingModel));
      return settingModel;
    } catch (e) {
      emit(SettingError(e.toString()));
      return Future.error(
          e); // Ensure a value is returned or an error is thrown
    }
  }
}
