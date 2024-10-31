import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../domain/entities/response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<User> register(
      String name, String email, String password, String phoneNumber) async {
    return await remoteDataSource.register(name, email, password, phoneNumber);
  }

  @override
  Future<Response> sendOTP(String phoneNumber) async {
    return await remoteDataSource.sendOTP(phoneNumber);
  }

  @override
  Future<Response> verifyOTP(String phoneNumber, String otp) async {
    return await remoteDataSource.verifyOTP(phoneNumber, otp);
  }

  @override
  Future<Response> forgetPassword(
      String phoneNumber, String newPassword) async {
    return await remoteDataSource.forgetPassword(phoneNumber, newPassword);
  }
}
