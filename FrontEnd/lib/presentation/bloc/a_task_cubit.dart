// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasks_usercase.dart';
import 'package:se121_giupviec_app/presentation/bloc/a_task_state.dart';

class ATaskCubit extends Cubit<ATaskState> {
  final GetATasksUsecase getATasksUsercase;

  ATaskCubit({required this.getATasksUsercase}) : super(ATaskInitial());

  Future<void> getATasks(int taskId) async {
    emit(ATaskLoading());
    try {
      print("chay vao Acubit");
      final task = await getATasksUsercase.execute(taskId);
      final List<TaskerList> taskerList =
          await getATasksUsercase.execute2(taskId);

      emit(ATaskSuccess(task, taskerList));
    } catch (e) {
      emit(ATaskError(e.toString()));
    }
  }
}
