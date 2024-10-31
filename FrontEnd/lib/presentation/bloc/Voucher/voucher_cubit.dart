// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/Voucher/get_all_vouchcer_usecase.dart';
import 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  final GetAllVoucherUseCase getAllVoucherUseCase;

  VoucherCubit({required this.getAllVoucherUseCase}) : super(VoucherInitial());

  Future<void> getAllVoucher() async {
    emit(VoucherLoading());
    try {
      print("chay vao cubit");
      final vouchers = await getAllVoucherUseCase.execute();
      emit(VoucherSuccess(vouchers));
    } catch (e) {
      emit(VoucherError(e.toString()));
    }
  }
}
