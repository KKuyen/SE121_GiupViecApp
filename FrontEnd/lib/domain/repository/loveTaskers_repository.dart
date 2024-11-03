// lib/domain/repository/task_repository.dart
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/domain/entities/BlockTasker.dart';
import 'package:se121_giupviec_app/domain/entities/loveTasker.dart';

import '../entities/task.dart';

abstract class LoveTaskersRepository {
  Future<List<LoveTasker>> getAllLoveTaskers(int userId);
  Future<List<BlockTasker>> getAllBlockTaskers(int userId);
  Future<void> love(int userId, int taskerId);
  Future<void> unlove(int userId, int taskerId);
  Future<void> block(int userId, int taskerId);
  Future<void> unblock(int userId, int taskerId);
}
