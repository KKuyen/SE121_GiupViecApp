// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/usecases/Voucher/claim_voucher_usecase.dart';

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
