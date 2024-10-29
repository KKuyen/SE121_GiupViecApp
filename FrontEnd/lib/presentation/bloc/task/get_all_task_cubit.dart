// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/get_all_task_state.dart';
import '../../../../domain/usecases/get_all_tasks_usecase.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;

  TaskCubit({required this.getAllTasksUseCase}) : super(TaskInitial());

  Future<void> getAllTasks(int userId) async {
    emit(TaskLoading());
    try {
      print("chay vao cubit");
      final TS1tasks = await getAllTasksUseCase.execute(userId);
      final TS2tasks = await getAllTasksUseCase.execute2(userId);
      final TS3tasks = await getAllTasksUseCase.execute3(userId);
      final TS4tasks = await getAllTasksUseCase.execute4(userId);

      emit(TaskSuccess(TS1tasks, TS2tasks, TS3tasks, TS4tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
