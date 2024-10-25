// lib/domain/usecases/register_usecase.dart
import '../entities/user.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> execute(
      String fullName, String email, String password, String phone) async {
    return await repository.register(fullName, email, password, phone);
  }
}
