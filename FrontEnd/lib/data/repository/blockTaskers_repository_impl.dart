import 'package:se121_giupviec_app/data/datasources/BlockTaskers_remote_datasource.dart';

import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';

import 'package:se121_giupviec_app/domain/repository/BlockTaskers_repository.dart';

class BlockTaskersRepositoryImpl implements BlockTaskersRepository {
  final BlockTaskersRemoteDatasource remoteDataSource;

  BlockTaskersRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<BlockTasker>> getAllBlockTaskers(int userId) async {
    return await remoteDataSource.getAllBlockTaskers(userId);
  }
}
