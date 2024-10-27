import '../../entities/response.dart';
import '../../repository/auth_repository.dart';

class ForgetPassUseCase {
  final AuthRepository repository;

  ForgetPassUseCase(this.repository);

  Future<Response> execute(String phoneNumber, String newPassword) async {
    return await repository.forgetPassword(phoneNumber, newPassword);
  }
}
