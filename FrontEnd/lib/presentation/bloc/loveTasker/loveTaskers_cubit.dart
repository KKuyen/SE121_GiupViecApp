// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';
import 'package:se121_giupviec_app/domain/entities/loveTasker.dart';

import 'package:se121_giupviec_app/domain/usecases/get_all_love_taskers_usecase.dart';

import 'package:se121_giupviec_app/presentation/bloc/loveTasker/loveTaskers_state.dart';
import 'package:se121_giupviec_app/presentation/bloc/notification/notification_cubit.dart';

class LoveTaskersCubit extends Cubit<LoveTaskersState> {
  final GetAllLoveTaskersUsecase getLoveTaskerssUsercase;

  LoveTaskersCubit({required this.getLoveTaskerssUsercase})
      : super(LoveTaskersInitial());

  Future<void> getLoveTaskers(int userId) async {
    emit(LoveTaskersLoading());
    try {
      print("chay vao Acubit");

      final List<LoveTasker> lovetaskerList =
          (await getLoveTaskerssUsercase.execute(userId));
      final List<BlockTasker> blocktaskerList =
          (await getLoveTaskerssUsercase.execute2(userId));
      emit(LoveTaskersSuccess(lovetaskerList, blocktaskerList));
    } catch (e) {
      emit(LoveTaskersError(e.toString()));
    }
  }

  Future<void> loveTaskers(int userId, int taskerId) async {
    try {
      await getLoveTaskerssUsercase.love(userId, taskerId);
    } catch (e) {
      emit(LoveTaskersError(e.toString()));
    }
  }

  Future<void> unloveTasker(int userId, int taskerId) async {
    try {
      print("chay vao Acubit");
      await getLoveTaskerssUsercase.unlove(userId, taskerId);
    } catch (e) {
      emit(LoveTaskersError(e.toString()));
    }
  }

  Future<void> blockTasker(int userId, int taskerId) async {
    try {
      await getLoveTaskerssUsercase.block(userId, taskerId);
    } catch (e) {
      emit(LoveTaskersError(e.toString()));
    }
  }

  Future<void> unblockTasker(int userId, int taskerId) async {
    try {
      print("chay vao Acubit");
      await getLoveTaskerssUsercase.unblock(userId, taskerId);
    } catch (e) {
      emit(LoveTaskersError(e.toString()));
    }
  }
}
