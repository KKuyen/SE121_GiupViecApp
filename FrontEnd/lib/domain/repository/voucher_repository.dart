// lib/domain/repository/task_repository.dart

import 'package:se121_giupviec_app/domain/entities/voucher.dart';

abstract class VoucherRepository {
  Future<List<Voucher>> getAllVoucher();
}
