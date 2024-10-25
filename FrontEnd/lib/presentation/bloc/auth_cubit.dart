import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.execute(email, password);
      print("user:" + user.user.toString());
      if (user.errCode == 0) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthError(user.message));
      }
    } catch (e) {
      print("loiiiiiii $e");
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(
      String fullName, String email, String password, String phone) async {
    emit(AuthLoading());
    try {
      final user =
          await registerUseCase.execute(fullName, email, password, phone);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
