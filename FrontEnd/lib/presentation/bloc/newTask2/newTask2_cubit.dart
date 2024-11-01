// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:se121_giupviec_app/domain/entities/location.dart';

import 'package:se121_giupviec_app/domain/usecases/new_task1_usecase.dart';

import 'package:se121_giupviec_app/presentation/bloc/newTask2/newTask2_state.dart';

class NewTask2Cubit extends Cubit<NewTask2State> {
  final NewTask1Usecase NewTask2Usecase;

  NewTask2Cubit({required this.NewTask2Usecase}) : super(NewTask2Initial());

  Future<void> getLocation(int userId) async {
    emit(NewTask2Loading());
    try {
      print("vao location roi");

      final Location dfLocation = (await NewTask2Usecase.execute3(userId));
      final List<Location> Mylocations =
          (await NewTask2Usecase.execute4(userId));
      emit(NewTask2Success(dfLocation, Mylocations));
    } catch (e) {
      emit(NewTask2Error(e.toString()));
    }
  }

  Future<void> Loading() async {
    emit(NewTask2Loading());
  }
}
