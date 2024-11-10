import 'package:se121_giupviec_app/domain/entities/response.dart';

import '../../domain/entities/location.dart';
import '../../domain/repository/location_repository.dart';
import '../datasources/location_remote_datasource.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDatasource remoteDataSource;

  LocationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Location>> getMyLocation(int userId) async {
    return await remoteDataSource.getMyLocation(userId);
  }

  @override
  Future<Location> getMyDefaultLocation(int userId) async {
    return await remoteDataSource.getMyDefaultLocation(userId);
  }

  @override
  Future<Response> addNewLocation(
      String? ownerName,
      String? ownerPhoneNumber,
      String country,
      String province,
      String district,
      String detailAddress,
      String map,
      int userId,
      bool isDefault) async {
    return await remoteDataSource.addNewLocation(ownerName!, ownerPhoneNumber!,
        country, province, district, detailAddress, map, userId, isDefault);
  }

  @override
  Future<Response> deleteLocation(int id) async {
    return await remoteDataSource.deleteLocation(id);
  }
}
