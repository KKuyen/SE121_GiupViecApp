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
}
