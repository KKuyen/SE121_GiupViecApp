// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';
import 'package:se121_giupviec_app/domain/entities/loveTasker.dart';

import 'package:se121_giupviec_app/domain/usecases/get_all_love_taskers_usecase.dart';

import 'package:se121_giupviec_app/presentation/bloc/loveTasker/loveTaskers_state.dart';

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
}
