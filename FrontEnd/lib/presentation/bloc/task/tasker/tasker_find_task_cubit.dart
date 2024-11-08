// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/taskType.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasker_usercase.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_find_task_state.dart';
import '../../../../domain/usecases/get_all_tasks_usecase.dart';

class TaskerFindTaskCubit extends Cubit<TaskerFindTaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  final GetATaskerUsercase getATaskerUsercase;
  TaskerFindTaskCubit(
      {required this.getAllTasksUseCase, required this.getATaskerUsercase})
      : super(TaskerFindTaskInitial());

  Future<void> getFindTasks(int taskerId) async {
    emit(TaskerFindTaskLoading());
    try {
      print("chay vao cubit");
      final findTasks = await getAllTasksUseCase.taskerfindtask(taskerId);

      final List<TaskType> taskTypeList = (await getATaskerUsercase.execute2());
      emit(TaskerFindTaskSuccess(findTasks, taskTypeList));
    } catch (e) {
      emit(TaskerFindTaskError(e.toString()));
    }
  }

  Future<void> applyTask(int taskerId, int taskId) async {
    try {
      print("chay vao cubit");
      await getAllTasksUseCase.applyTask(taskerId, taskId);
    } catch (e) {
      emit(TaskerFindTaskError(e.toString()));
    }
  }
}
