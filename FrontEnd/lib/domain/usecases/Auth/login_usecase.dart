// lib/domain/usecases/login_usecase.dart
import '../../entities/user.dart';
import '../../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> execute(String email, String password) async {
    return await repository.login(email, password);
  }
}
