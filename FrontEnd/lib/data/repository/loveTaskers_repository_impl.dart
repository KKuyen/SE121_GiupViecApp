import 'package:se121_giupviec_app/data/datasources/loveTaskers_remote_datasource.dart';
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';
import 'package:se121_giupviec_app/domain/entities/loveTasker.dart';
import 'package:se121_giupviec_app/domain/repository/loveTaskers_repository.dart';

class LoveTaskersRepositoryImpl implements LoveTaskersRepository {
  final LoveTaskersRemoteDatasource remoteDataSource;

  LoveTaskersRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<LoveTasker>> getAllLoveTaskers(int userId) async {
    return await remoteDataSource.getAllLoveTaskers(userId);
  }

  @override
  Future<List<BlockTasker>> getAllBlockTaskers(int userId) async {
    return await remoteDataSource.getAllBlockTaskers(userId);
  }

  @override
  Future<void> love(int userId, int taskerId) async {
    // TODO: implement love
    return await remoteDataSource.love(userId, taskerId);
  }

  @override
  Future<void> unlove(int userId, int taskerId) async {
    // TODO: implement unlove
    return await remoteDataSource.unlove(userId, taskerId);
  }

  @override
  Future<void> block(int userId, int taskerId) async {
    return await remoteDataSource.block(userId, taskerId);
  }

  @override
  Future<void> unblock(int userId, int taskerId) async {
    return await remoteDataSource.unblock(userId, taskerId);
  }
}
