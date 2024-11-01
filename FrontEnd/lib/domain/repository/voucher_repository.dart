// lib/domain/repository/task_repository.dart

import 'package:se121_giupviec_app/domain/entities/response.dart';
import 'package:se121_giupviec_app/domain/entities/voucher.dart';

abstract class VoucherRepository {
  Future<List<Voucher>> getAllVoucher();
  Future<Response> claimVoucher(int userId, int voucherId);
}
