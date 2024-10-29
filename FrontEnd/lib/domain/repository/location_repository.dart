// lib/domain/repository/task_repository.dart

import 'package:se121_giupviec_app/domain/entities/location.dart';

import '../entities/response.dart';

abstract class LocationRepository {
  Future<List<Location>> getMyLocation(int userId);
  Future<Location> getMyDefaultLocation(int userId);
  Future<Response> addNewLocation(
      String ownerName,
      String ownerPhoneNumber,
      String country,
      String province,
      String district,
      String detailAddress,
      String map,
      int userId,
      bool isDefault);
  Future<Response> deleteLocation(int id);
}
