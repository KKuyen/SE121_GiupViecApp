// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/Location/delete_location_usecase.dart';
import '../../../domain/usecases/Location/get_my_location_usecase.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetMyLocationUseCase getMyLocationUseCase;
  final DeleteLocationUseCase deleteLocationUseCase;
  LocationCubit({
    required this.getMyLocationUseCase,
    required this.deleteLocationUseCase,
  }) : super(LocationInitial());

  Future<void> getMyLocation(int userId) async {
    emit(LocationLoading());
    try {
      print("chay vao cubit");
      final Locations = await getMyLocationUseCase.execute(userId);
      emit(LocationSuccess(Locations));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

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
