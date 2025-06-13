// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:se121_giupviec_app/domain/entities/taskType.dart';

import 'package:se121_giupviec_app/domain/usecases/new_task1_usecase.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask1/newTask1_state.dart';

class NewTask1Cubit extends Cubit<NewTask1State> {
  final NewTask1Usecase newTask1Usecase;

  NewTask1Cubit({required this.newTask1Usecase}) : super(NewTask1Initial());

  Future<void> getTaskType(int taskTypeId) async {
    emit(NewTask1Loading());
    try {
      print("chay vao Acubit");

      final TaskType taskType = (await newTask1Usecase.execute(taskTypeId));

      emit(NewTask1Success(taskType));
    } catch (e) {
      emit(NewTask1Error(e.toString()));
    }
  }

  Future<void> createTask(
      int userId,
      int taskTypeId,
      DateTime time,
      int locationId,
      String note,
      int myvoucherId,
      int voucherId,
      String paymentMethod,
      List<Map<String, dynamic>> addPriceDetail) async {
    try {
      print("chay vao cubit create task");

      await newTask1Usecase.execute2(userId, taskTypeId, time, locationId, note,
          myvoucherId, voucherId, paymentMethod, addPriceDetail);
      emit(NewTask1Loading());
    } catch (e) {
      emit(NewTask1Error(e.toString()));
    }
  }
}
