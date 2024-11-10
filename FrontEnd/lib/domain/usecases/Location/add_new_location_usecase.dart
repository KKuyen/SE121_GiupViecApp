import 'package:se121_giupviec_app/domain/entities/response.dart';

import '../../repository/location_repository.dart';

class AddNewLocationUseCase {
  final LocationRepository repository;

  AddNewLocationUseCase(this.repository);

  Future<Response> execute(
      String? ownerName,
      String? ownerPhoneNumber,
      String country,
      String province,
      String district,
      String detailAddress,
      String map,
      int userId,
      bool isDefault) async {
    return await repository.addNewLocation(ownerName!, ownerPhoneNumber!,
        country, province, district, detailAddress, map, userId, isDefault);
  }
}
