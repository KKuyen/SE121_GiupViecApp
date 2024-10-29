import '../../entities/location.dart';
import '../../repository/location_repository.dart';

class GetMyDefaultLocationUseCase {
  final LocationRepository repository;

  GetMyDefaultLocationUseCase(this.repository);

  Future<Location> execute(int userId) async {
    return await repository.getMyDefaultLocation(userId);
  }
}
