// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/Location/get_my_default_location.dart';
import 'location_state.dart';

class DefaultLocationCubit extends Cubit<LocationState> {
  final GetMyDefaultLocationUseCase getMyDefaultLocationUseCase;

  DefaultLocationCubit({required this.getMyDefaultLocationUseCase})
      : super(LocationInitial());

  Future<void> getMyDefaultLocation(int userId) async {
    emit(DefaultLocationLoading());
    try {
      print("chay vao cubit");
      final Locations = await getMyDefaultLocationUseCase.execute(userId);
      emit(DefaultLocationSuccess(Locations));
    } catch (e) {
      emit(DefaultLocationError(e.toString()));
    }
  }
}
