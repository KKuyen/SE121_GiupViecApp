// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasks_usercase.dart';

import 'package:se121_giupviec_app/presentation/bloc/tasker_list/taskerlist_state.dart';

class TaskerlistCubit extends Cubit<TaskerListState> {
  final GetATasksUsecase getATasksUsercase;

  TaskerlistCubit({required this.getATasksUsercase})
      : super(TaskerListInitial());

  Future<void> getTaskerList(int taskId) async {
    emit(TaskerListLoading());
    try {
      print("chay vao Acubit");

      final List<TaskerList> taskerList =
          await getATasksUsercase.execute2(taskId);

      emit(TaskerListSuccess(taskerList));
    } catch (e) {
      emit(TaskerListError(e.toString()));
    }
  }
}
