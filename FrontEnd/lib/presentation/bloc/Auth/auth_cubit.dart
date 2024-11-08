import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/usecases/Auth/sendOTP.dart';
import 'package:se121_giupviec_app/domain/usecases/Auth/verifyOTP.dart';
import '../../../domain/usecases/Auth/edit_profile_usecase.dart';
import '../../../domain/usecases/Auth/forget_pass_usecase.dart';
import '../../../domain/usecases/Auth/login_usecase.dart';
import '../../../domain/usecases/Auth/register_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final SendOTPUseCase sendOTPUseCase;
  final VerifyOTPUseCase verifyOTPUseCase;
  final ForgetPassUseCase forgetPassUseCase;
  final EditProfileUsecase editProfileUsecase;
  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.sendOTPUseCase,
    required this.verifyOTPUseCase,
    required this.forgetPassUseCase,
    required this.editProfileUsecase,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.execute(email, password);
      print("user:${user.user}");
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
      String name, String email, String password, String phoneNumber) async {
    emit(AuthLoading());
    try {
      final user =
          await registerUseCase.execute(name, email, password, phoneNumber);
      if (user.errCode == 0) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthError(user.message));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> editProfile(int userId, String name, String email,
      String phoneNumber, String avatar) async {
    emit(AuthLoading());
    try {
      final ress = await editProfileUsecase.execute(
          userId, name, email, phoneNumber, avatar);
      if (ress.errCode == 0) {
        emit(AuthResponseSuccess(ress));
      } else {
        emit(AuthError(ress.message));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> sendOTP(String phoneNumber) async {
    emit(AuthLoading());
    try {
      final response = await sendOTPUseCase.execute(phoneNumber);
      if (response.errCode == 0) {
        emit(AuthResponseSuccess(response));
      } else {
        emit(AuthError(response.message));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyOTP(String phoneNumber, String otp) async {
    emit(AuthLoading());
    try {
      final response = await verifyOTPUseCase.execute(phoneNumber, otp);
      if (response.errCode == 0) {
        emit(AuthResponseSuccess(response));
      } else {
        emit(AuthError(response.message));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> forgetPassword(String phoneNumber, String newPassword) async {
    //emit(AuthLoading());
    try {
      final response =
          await forgetPassUseCase.execute(phoneNumber, newPassword);
      if (response.errCode == 0) {
        emit(AuthResponseSuccess(response));
      } else {
        emit(AuthError(response.message));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
