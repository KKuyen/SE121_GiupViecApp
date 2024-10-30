// lib/domain/repository/task_repository.dart
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';

abstract class BlockTaskersRepository {
  Future<List<BlockTasker>> getAllBlockTaskers(int userId);
}
