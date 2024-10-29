// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/Location/add_new_location_usecase.dart';
import 'location_state.dart';

class AddLocationCubit extends Cubit<LocationState> {
  final AddNewLocationUseCase addNewLocationUseCase;
  AddLocationCubit({
    required this.addNewLocationUseCase,
  }) : super(LocationInitial());

  Future<void> addNewLocation(
      String ownerName,
      String ownerPhoneNumber,
      String country,
      String province,
      String district,
      String detailAddress,
      String map,
      int userId,
      bool isDefault) async {
    emit(LocationLoading());
    try {
      final response = await addNewLocationUseCase.execute(
          ownerName,
          ownerPhoneNumber,
          country,
          province,
          district,
          detailAddress,
          map,
          userId,
          isDefault);
      if (response.errCode == 0) {
        emit(LocationResponseSuccess(response));
      } else {
        emit(LocationError(response.message));
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}