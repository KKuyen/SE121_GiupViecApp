// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';
import 'package:se121_giupviec_app/domain/entities/loveTasker.dart';

import 'package:se121_giupviec_app/domain/repository/loveTaskers_repository.dart';

class GetAllLoveTaskersUsecase {
  final LoveTaskersRepository repository;

  GetAllLoveTaskersUsecase(this.repository);

  Future<List<LoveTasker>> execute(int userId) async {
    return await repository.getAllLoveTaskers(userId);
  }

  Future<List<BlockTasker>> execute2(int userId) async {
    return await repository.getAllBlockTaskers(userId);
  }
}
