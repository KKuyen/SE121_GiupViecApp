// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasks_usercase.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_state.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/approveWidget_state.dart';

class AWCubit extends Cubit<AWState> {
  final GetATasksUsecase getATasksUsercase;

  AWCubit({required this.getATasksUsercase}) : super(AWInitial());

  Future<void> getATasks(int taskId) async {
    emit(AWLoading());
    try {
      print("chay vao Acubit");

      final List<TaskerList> taskerList =
          await getATasksUsercase.execute2(taskId);

      emit(AWSuccess(taskerList));
    } catch (e) {
      emit(AWError(e.toString()));
    }
  }
}
