// lib/domain/usecases/get_all_tasks_usecase.dart
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';

import 'package:se121_giupviec_app/domain/repository/BlockTaskers_repository.dart';

class GetAllBlockTaskersUsecase {
  final BlockTaskersRepository repository;

  GetAllBlockTaskersUsecase(this.repository);

  Future<List<BlockTasker>> execute(int userId) async {
    return await repository.getAllBlockTaskers(userId);
  }
}
