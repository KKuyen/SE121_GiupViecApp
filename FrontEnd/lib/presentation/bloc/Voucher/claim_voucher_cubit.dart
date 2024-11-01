// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/usecases/Voucher/claim_voucher_usecase.dart';
import 'voucher_state.dart';

class ClaimVoucherCubit extends Cubit<VoucherState> {
  final ClaimVoucherUseCase claimVoucherUseCase;

  ClaimVoucherCubit({required this.claimVoucherUseCase})
      : super(VoucherInitial());

  Future<void> claimVoucher(int userId, int voucherId) async {
    emit(VoucherLoading());
    try {
      print("chay vao cubit");
      final res = await claimVoucherUseCase.execute(userId, voucherId);
      emit(ResponseVoucherSuccess(res));
    } catch (e) {
      emit(VoucherError(e.toString()));
    }
  }
}
