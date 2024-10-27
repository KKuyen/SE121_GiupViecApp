// lib/domain/repositories/auth_repository.dart

import '../entities/user.dart';
import '../entities/response.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(
      String name, String email, String password, String phoneNumber);
  Future<Response> sendOTP(String phoneNumber);
  Future<Response> verifyOTP(String phoneNumber, String otp);
  Future<Response> forgetPassword(String phoneNumber, String newPassword);
}
