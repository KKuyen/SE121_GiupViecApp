// lib/domain/usecases/register_usecase.dart
import 'package:se121_giupviec_app/domain/entities/response.dart';

import '../../entities/user.dart';
import '../../repository/auth_repository.dart';

class EditProfileUsecase {
  final AuthRepository repository;

  EditProfileUsecase(this.repository);

  Future<Response> execute(int userId, String name, String email,
      String phoneNumber, String avatar) async {
    return await repository.editProfile(
        userId, name, email, phoneNumber, avatar);
  }
}
