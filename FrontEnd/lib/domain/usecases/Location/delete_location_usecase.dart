import 'package:se121_giupviec_app/domain/entities/response.dart';

import '../../repository/location_repository.dart';

class DeleteLocationUseCase {
  final LocationRepository repository;

  DeleteLocationUseCase(this.repository);

  Future<Response> execute(int id) async {
    return await repository.deleteLocation(id);
  }
}
