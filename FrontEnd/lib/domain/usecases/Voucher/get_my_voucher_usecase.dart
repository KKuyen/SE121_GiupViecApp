// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/domain/entities/voucher.dart';

import '../../repository/voucher_repository.dart';

class GetMyVoucherUseCase {
  final VoucherRepository repository;

  GetMyVoucherUseCase(this.repository);

  Future<List<Voucher>> execute(int userId) async {
    return await repository.getMyVoucher(userId);
  }
}
