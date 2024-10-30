// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';
import 'package:se121_giupviec_app/domain/entities/loveTasker.dart';
import 'package:se121_giupviec_app/domain/entities/taskType.dart';

import 'package:se121_giupviec_app/domain/usecases/get_all_love_taskers_usecase.dart';
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
}
