// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/domain/entities/response.dart';

import '../../repository/voucher_repository.dart';

class DeleteMyVoucherUseCase {
  final VoucherRepository repository;

  DeleteMyVoucherUseCase(this.repository);

  Future<Response> execute(int userId, int voucherId) async {
    return await repository.deleteMyVoucher(userId, voucherId);
  }
}
