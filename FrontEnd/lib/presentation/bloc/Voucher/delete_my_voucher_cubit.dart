// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/Voucher/delete_my_voucher_usecase.dart';
import 'voucher_state.dart';

class DeleteMyVoucherCubit extends Cubit<VoucherState> {
  final DeleteMyVoucherUseCase deleteMyVoucherUseCase;

  DeleteMyVoucherCubit({required this.deleteMyVoucherUseCase})
      : super(VoucherInitial());

  Future<void> deleteMyVoucher(int userId, int voucherId) async {
    emit(VoucherLoading());
    try {
      print("chay vao cubit");
      final res = await deleteMyVoucherUseCase.execute(userId, voucherId);
      emit(ResponseVoucherSuccess(res));
    } catch (e) {
      emit(VoucherError(e.toString()));
    }
  }
}
