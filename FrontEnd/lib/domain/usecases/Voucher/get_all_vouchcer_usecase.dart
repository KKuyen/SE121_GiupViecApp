// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/domain/entities/voucher.dart';

import '../../repository/voucher_repository.dart';

class GetAllVoucherUseCase {
  final VoucherRepository repository;

  GetAllVoucherUseCase(this.repository);

  Future<List<Voucher>> execute() async {
    return await repository.getAllVoucher();
  }
}
