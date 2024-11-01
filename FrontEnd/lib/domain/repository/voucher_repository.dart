// lib/domain/repository/task_repository.dart

import 'package:se121_giupviec_app/domain/entities/response.dart';
import 'package:se121_giupviec_app/domain/entities/voucher.dart';

abstract class VoucherRepository {
  Future<List<Voucher>> getAllVoucher();
  Future<List<Voucher>> getMyVoucher(int userId);

  Future<Response> claimVoucher(int userId, int voucherId);
  Future<Response> deleteMyVoucher(int userId, int voucherId);
}
