import 'package:se121_giupviec_app/domain/entities/response.dart';

import '../../domain/entities/voucher.dart';
import '../../domain/repository/voucher_repository.dart';
import '../datasources/voucher_remote_datasourse.dart';

class VoucherRepositoryImpl implements VoucherRepository {
  final VoucherRemoteDatasource remoteDataSource;

  VoucherRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Voucher>> getAllVoucher() async {
    return await remoteDataSource.getAllVoucher();
  }

  @override
  Future<List<Voucher>> getMyVoucher(int userId) async {
    return await remoteDataSource.getMyVoucher(userId);
  }

  @override
  Future<Response> claimVoucher(int userId, int voucherId) async {
    return await remoteDataSource.claimVoucher(userId, voucherId);
  }

  @override
  Future<Response> deleteMyVoucher(int userId, int voucherId) async {
    return await remoteDataSource.deleteMyVoucher(userId, voucherId);
  }
}
