// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/Voucher/get_all_vouchcer_usecase.dart';
import '../../../domain/usecases/Voucher/get_my_voucher_usecase.dart';
import 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  final GetAllVoucherUseCase getAllVoucherUseCase;
  final GetMyVoucherUseCase getMyVoucherUseCase;

  VoucherCubit({
    required this.getAllVoucherUseCase,
    required this.getMyVoucherUseCase,
  }) : super(VoucherInitial());

  Future<void> getAllVoucher(int filter) async {
    emit(VoucherLoading());
    try {
      print("chay vao cubit");
      final vouchers = await getAllVoucherUseCase.execute();
      //filter=1: get all voucher theo Rpoint tăng dần
      if (filter == 1) {
        vouchers.sort((a, b) => a.RpointCost.compareTo(b.RpointCost));
      }
      //filter=2: get all voucher theo Rpoint giảm dần
      if (filter == 2) {
        vouchers.sort((a, b) => b.RpointCost.compareTo(a.RpointCost));
      }
      emit(VoucherSuccess(vouchers));
    } catch (e) {
      emit(VoucherError(e.toString()));
    }
  }

  Future<void> getMyVoucher(int userId) async {
    emit(VoucherLoading());
    try {
      print("chay vao cubit");
      final vouchers = await getMyVoucherUseCase.execute(userId);
      emit(VoucherSuccess(vouchers));
    } catch (e) {
      emit(VoucherError(e.toString()));
    }
  }
}
