// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/Location/get_my_location.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetMyLocationUseCase getMyLocationUseCase;

  LocationCubit({
    required this.getMyLocationUseCase,
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
}
