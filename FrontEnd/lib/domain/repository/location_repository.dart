// lib/domain/repository/task_repository.dart

import 'package:se121_giupviec_app/domain/entities/location.dart';

abstract class LocationRepository {
  Future<List<Location>> getMyLocation(int userId);
}
