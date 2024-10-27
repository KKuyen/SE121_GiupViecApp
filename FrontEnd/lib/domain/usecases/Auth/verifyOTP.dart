// lib/domain/usecases/login_usecase.dart
import 'package:se121_giupviec_app/domain/entities/response.dart';

import '../../entities/user.dart';
import '../../repository/auth_repository.dart';

class VerifyOTPUseCase {
  final AuthRepository repository;

  VerifyOTPUseCase(this.repository);

  Future<Response> execute(String phoneNumber, String otp) async {
    return await repository.verifyOTP(phoneNumber, otp);
  }
}
