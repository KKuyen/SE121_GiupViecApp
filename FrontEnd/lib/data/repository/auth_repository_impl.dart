import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

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
}
