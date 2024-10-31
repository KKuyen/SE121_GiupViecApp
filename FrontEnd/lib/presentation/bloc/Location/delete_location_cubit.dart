// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/Location/delete_location_usecase.dart';
import 'location_state.dart';

class DeleteLocationCubit extends Cubit<LocationState> {
  final DeleteLocationUseCase deleteLocationUseCase;
  DeleteLocationCubit({
    required this.deleteLocationUseCase,
  }) : super(LocationInitial());

  Future<void> deleteLocation(int id) async {
    emit(LocationLoading());
    try {
      print("chay vao cubit");
      final response = await deleteLocationUseCase.execute(id);
      emit(LocationResponseSuccess(response));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
