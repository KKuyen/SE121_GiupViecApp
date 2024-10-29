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

  Future<Location> getMyDefaultLocation(int userId) async {
    return await remoteDataSource.getMyDefaultLocation(userId);
  }
}
