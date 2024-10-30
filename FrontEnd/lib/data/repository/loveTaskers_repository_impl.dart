import 'package:se121_giupviec_app/data/datasources/loveTaskers_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';
import 'package:se121_giupviec_app/domain/entities/loveTasker.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
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
}
