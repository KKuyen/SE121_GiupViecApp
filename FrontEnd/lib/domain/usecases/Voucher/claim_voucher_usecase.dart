// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/domain/entities/response.dart';

import '../../repository/voucher_repository.dart';

class ClaimVoucherUseCase {
  final VoucherRepository repository;

  ClaimVoucherUseCase(this.repository);

  Future<Response> execute(int userId, int voucherId) async {
    return await repository.claimVoucher(userId, voucherId);
  }
}
