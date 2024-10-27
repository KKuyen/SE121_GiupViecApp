// lib/domain/usecases/register_usecase.dart
import '../../entities/user.dart';
import '../../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> execute(
      String name, String email, String password, String phoneNumber) async {
    return await repository.register(name, email, password, phoneNumber);
  }
}
