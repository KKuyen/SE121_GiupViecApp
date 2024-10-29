// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/TaskType/get_all_tasktype_usecase.dart';
import 'get_all_tasktype_state.dart';

class TaskTypeCubit extends Cubit<TaskTypeState> {
  final GetAllTasksTypeUseCase getAllTasksTypeUseCase;
  var cacheTaskTypes;
  TaskTypeCubit({required this.getAllTasksTypeUseCase}) : super(TaskInitial());

  Future<void> getAllTypeTasks() async {
    if (cacheTaskTypes != null) {
      emit(TaskSuccess(cacheTaskTypes));
      return;
    }
    emit(TaskLoading());
    try {
      print("chay vao cubit");
      final tasks = await getAllTasksTypeUseCase.execute();
      cacheTaskTypes = tasks;
      emit(TaskSuccess(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
