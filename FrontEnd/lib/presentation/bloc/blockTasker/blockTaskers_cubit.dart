// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';
import 'package:se121_giupviec_app/domain/usecases/get_all_block_taskers_usecase.dart';

import 'package:se121_giupviec_app/presentation/bloc/blockTasker/blockTaskers_state.dart';

class BlockTaskersCubit extends Cubit<BlockTaskersState> {
  final GetAllBlockTaskersUsecase getBlockTaskerssUsercase;

  BlockTaskersCubit({required this.getBlockTaskerssUsercase})
      : super(BlockTaskersInitial());

  Future<void> getBlockTaskers(int userId) async {
    emit(BlockTaskersLoading());
    try {
      print("chay vao Acubit");

      final List<BlockTasker> blockTaskerList =
          (await getBlockTaskerssUsercase.execute(userId));

      emit(BlockTaskersSuccess(blockTaskerList));
    } catch (e) {
      emit(BlockTaskersError(e.toString()));
    }
  }
}
