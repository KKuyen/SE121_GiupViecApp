// lib/domain/usecases/login_usecase.dart
import 'package:se121_giupviec_app/domain/entities/response.dart';

import '../../repository/auth_repository.dart';

class SendOTPUseCase {
  final AuthRepository repository;

  SendOTPUseCase(this.repository);

  Future<Response> execute(String phoneNumber) async {
    return await repository.sendOTP(phoneNumber);
  }
}
