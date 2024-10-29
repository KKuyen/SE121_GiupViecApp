// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/entities/tasker_info.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasker_usercase.dart';

import 'package:se121_giupviec_app/presentation/bloc/tasker/tasker_state.dart';

class TaskerCubit extends Cubit<TaskerState> {
  final GetATaskerUsercase getATaskerUsercase;

  TaskerCubit({required this.getATaskerUsercase}) : super(TaskerInitial());

  Future<void> getATasker(int userId, int taskerId) async {
    emit(TaskerLoading());
    try {
      print("chay vao Acubit");

      final TaskerInfo taskerInfo =
          (await getATaskerUsercase.execute(userId, taskerId));

      emit(TaskerSuccess(taskerInfo));
    } catch (e) {
      emit(TaskerError(e.toString()));
    }
  }
}
