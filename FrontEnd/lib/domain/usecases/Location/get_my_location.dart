import '../../entities/location.dart';
import '../../repository/location_repository.dart';

class GetMyLocationUseCase {
  final LocationRepository repository;

  GetMyLocationUseCase(this.repository);

  Future<List<Location>> execute(int userId) async {
    return await repository.getMyLocation(userId);
  }
}
